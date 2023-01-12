import 'dart:async';
import 'dart:collection';

import 'package:commons/app_logger/ansi_parser.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';

class AppLogger {
  static final ListQueue<String> _outputEventBuffer = ListQueue();
  static const int _bufferSize = 500;
  static StreamController? _loggerStream;

  static void openConsoleLog() {
    Get.to(() => const _AppConsoleLog());
  }

  static dynamic startLogger(Widget app,
      {Future<void> Function()? onInitial}) async {
    await onInitial?.call();

    runZoned(() {
      runApp(app);
    }, zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) {
        parent.print(Zone.current, line);
        if (_outputEventBuffer.length == _bufferSize) {
          _outputEventBuffer.removeFirst();
        }
        _outputEventBuffer.add(line);

        if (_loggerStream != null &&
            (_loggerStream?.isClosed == false ||
                _loggerStream?.isPaused == false)) {
          _loggerStream!.sink.add(line);
        }
      },
    ));
  }
}

class _AppConsoleLog extends StatefulWidget {
  const _AppConsoleLog();

  @override
  State<_AppConsoleLog> createState() => __AppConsoleLogState();
}

class __AppConsoleLogState extends State<_AppConsoleLog> {
  late final List<String> log;
  late final ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();

    AppLogger._loggerStream = StreamController();

    log = [...AppLogger._outputEventBuffer.toList()];

    AppLogger._loggerStream?.stream.listen((event) {
      if (mounted) {
        setState(() {
          log.add(event);
          scrollController.animateTo(scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut);
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 2000,
          child: ListView.builder(
            controller: scrollController,
            shrinkWrap: true,
            itemCount: log.length,
            itemBuilder: (_, i) {
              final AnsiParser parser = AnsiParser(false);
              parser.parse(log[i]);
              return Text.rich(TextSpan(children: parser.spans));
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    AppLogger._loggerStream?.close();
    scrollController.dispose();
    AppLogger._loggerStream = null;
    super.dispose();
  }
}
