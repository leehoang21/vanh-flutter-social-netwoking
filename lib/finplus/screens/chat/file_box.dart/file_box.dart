import 'package:finplus/utils/styles.dart';
import 'package:flutter/material.dart';

enum DownloadState { complete, running }

class FileBox extends StatelessWidget {
  final Color? contentColor;
  final Color? backgroundColor;
  final VoidCallback onDownloadFile;

  const FileBox(
      {Key? key,
      this.contentColor,
      this.backgroundColor,
      required this.onDownloadFile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color contentColor = this.contentColor ?? context.t.background;
    final Color backgroundColor = this.backgroundColor ?? context.t.primaryChat;

    const DownloadState? stateDownload = null;
    const double perCentDownload = 0.0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: context.t.primaryChat,
          width: 1,
        ),
        borderRadius: Decorate.boxChatR,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox.square(
            dimension: 24,
            child: stateDownload == DownloadState.complete
                ? IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: Icon(
                      Icons.file_download,
                      color: contentColor,
                    ),
                  )
                : stateDownload == DownloadState.running
                    ? Stack(
                        children: [
                          Icon(
                            Icons.file_download,
                            color: contentColor,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 1,
                            child: SizedBox.square(
                              dimension: 14,
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: CircularProgressIndicator(
                                  strokeWidth: 1,
                                  color: backgroundColor,
                                  value: perCentDownload,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    : IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: onDownloadFile,
                        icon: Icon(
                          Icons.file_download,
                          color: contentColor,
                        ),
                      ),
          ),
          Spaces.boxW8,
          Text(
            'File name',
            style: TextStyle(color: contentColor),
          )
        ],
      ),
    );
  }
}
