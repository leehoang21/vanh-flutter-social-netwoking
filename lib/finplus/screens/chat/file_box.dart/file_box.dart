import 'package:finplus/models/chat_data.dart';
import 'package:finplus/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:open_filex/open_filex.dart';

class FileBox extends StatelessWidget {
  final RxChatData data;
  final Color? contentColor;
  final Color? backgroundColor;
  final VoidCallback onDownloadFile;

  const FileBox(
      {Key? key,
      required this.data,
      this.contentColor,
      this.backgroundColor,
      required this.onDownloadFile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color contentColor = this.contentColor ?? context.t.background;
    final Color backgroundColor = this.backgroundColor ?? context.t.primaryChat;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: context.t.primaryChat,
          width: 1,
        ),
        borderRadius: AppBorderAndRadius.boxChatBorderRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox.square(
            dimension: 24,
            child: data.downloadTaskStatus == DownloadTaskStatus.complete
                ? IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: data.filePath != null
                        ? () => OpenFilex.open(data.filePath)
                        : null,
                    icon: Icon(
                      Icons.file_download,
                      color: contentColor,
                    ),
                  )
                : data.downloadTaskStatus == DownloadTaskStatus.running
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
                                  value:
                                      data.value.downloadProgress?.toDouble() ??
                                          0.0,
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
            data.resource.first.name ?? '',
            style: TextStyle(color: contentColor),
          )
        ],
      ),
    );
  }
}
