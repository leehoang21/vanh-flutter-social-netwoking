import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewArgument {
  final String url;
  WebViewArgument({
    required this.url,
  });
}

class WebView extends StatelessWidget {
  const WebView({super.key});

  @override
  Widget build(BuildContext context) {
    final Rx<double> _progress = Rx(0);
    final WebViewArgument? argument = Get.arguments as WebViewArgument?;
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                url: Uri.parse(argument?.url ?? ''),
              ),
              onProgressChanged: (controller, progress) {
                _progress(progress / 100);
              },
            ),
            if (_progress.value < 1)
              SizedBox(
                child: LinearProgressIndicator(
                  value: _progress.value,
                ),
              )
          ],
        ),
      ),
    );
  }
}
