import 'dart:convert';

import 'package:commons/app_logger/app_logger.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:commons/commons.dart';

const _color = {
  'PENDING': Colors.amber,
  'ERROR': Colors.red,
  'SUCCESS': Colors.green
};

class NetworkLog extends StatefulWidget {
  const NetworkLog({super.key});

  @override
  State<NetworkLog> createState() => _NetworkLogState();
}

class _NetworkLogState extends State<NetworkLog> {
  late final List<NetWorkInfo> data;

  @override
  void initState() {
    data = AppLogger.listRequest.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, i) {
        return ExpandableNotifier(
          child: ScrollOnExpand(
            child: ExpandablePanel(
                theme: const ExpandableThemeData(hasIcon: false),
                header: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text('${data[i].method} : ${data[i].uri}')),
                      Column(
                        children: [
                          Text(
                            data[i].status,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _color[data[i].status],
                            ),
                          ),
                          Text(
                            'STT: ${data[i].statusCode?.toString() ?? '-'}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                collapsed: const SizedBox(),
                expanded: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Request headers:'),
                      SelectableText(const JsonEncoder.withIndent('    ')
                          .convert(data[i].headers)),
                      const SizedBox(height: 16),
                      const Text('Request body:'),
                      SelectableText(const JsonEncoder.withIndent('    ')
                          .convert(data[i].body)),
                      const SizedBox(height: 16),
                      const Text('Response body:'),
                      SelectableText(const JsonEncoder.withIndent('    ')
                          .convert(data[i].response)),
                    ],
                  ),
                )),
          ),
        );
      },
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemCount: data.length,
    );
  }
}
