import 'dart:io';

import 'package:commons/commons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:finplus/core/get_arguments.dart';
import 'package:finplus/models/chat_data.dart';
import 'package:finplus/models/login_info_data.dart';
import 'package:finplus/utils/permission_ultil/permisson_ultil.dart';
import 'package:finplus/utils/ui/app_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChatArgument {
  final UserInfo userChatWith;

  ChatArgument({
    required this.userChatWith,
  });
}

class ChatController extends GetxController with GetArguments<ChatArgument> {
  final String userId = '0';

  final TextEditingController textController = TextEditingController();

  final FocusNode focusInputMessageField = FocusNode();

  final Rx<List<RxChatData>> listChat = Rx([]);

  final Rx<bool> onExpandedInputField = Rx(false);

  final ScrollController scrollController = ScrollController();

  final RefreshController refreshController = RefreshController();

  late Rxn<UserInfo> userChatWith;

  @override
  void onInit() {
    textController.addListener(
      () {
        if (onExpandedInputField.value == false)
          onExpandedInputField.value = true;
      },
    );

    focusInputMessageField.addListener(
      () {
        if (focusInputMessageField.hasFocus &&
            onExpandedInputField.value == false)
          onExpandedInputField.value = true;

        if (!focusInputMessageField.hasFocus &&
            onExpandedInputField.value == true)
          onExpandedInputField.value = false;
      },
    );

    userChatWith = Rxn(arguments?.userChatWith);

    _load();
    super.onInit();
  }

  void _load() {
    //Add fake data
    listChat.update(
      (val) {
        val?.addAll(
          [
            RxChatData(
              ChatData(
                groupId: '',
                chatId: 'chatId',
                repId: 'repId',
                resource: [],
                content:
                    'content https://www.bing.com/search?q=can%27t+call+firstOrNull+flutter&cvid=1d4e3459330d41e6ac22d48f130ea702&aqs=edge..69i57j69i64.6657j0j1&pglt=163&FORM=ANNTA1&PC=U531&ntref=1',
                createTime: (DateTime.now().microsecondsSinceEpoch / 1000)
                    .toInt()
                    .toString(),
                userId: 'userId',
                username: 'username',
                userAvatar: 'userAvatar',
                replyResource: [],
                replyCreateTime: (DateTime.now().microsecondsSinceEpoch / 1000)
                    .toInt()
                    .toString(),
              ),
            ),
            RxChatData(
              ChatData(
                groupId: '',
                chatId: 'chatId',
                repId: 'repId',
                resource: [],
                content:
                    'content https://www.bing.com/search?q=can%27t+call+firstOrNull+flutter&cvid=1d4e3459330d41e6ac22d48f130ea702&aqs=edge..69i57j69i64.6657j0j1&pglt=163&FORM=ANNTA1&PC=U531&ntref=1',
                createTime: (DateTime.now().microsecondsSinceEpoch / 1000)
                    .toInt()
                    .toString(),
                userId: '0',
                username: 'username',
                userAvatar: 'userAvatar',
                replyResource: [],
                replyCreateTime:
                    ((DateTime.now().microsecondsSinceEpoch / 1000).toInt())
                        .toString(),
              ),
            ),
            RxChatData(
              ChatData(
                groupId: '',
                chatId: 'chatId',
                repId: 'repId',
                resource: [Resource(urlOrigin: '')],
                content: 'content',
                createTime: ((DateTime(2000).microsecondsSinceEpoch / 1000))
                    .toInt()
                    .toString(),
                userId: '0',
                username: 'username',
                userAvatar: 'userAvatar',
                replyResource: [],
                replyCreateTime:
                    ((DateTime(2000).microsecondsSinceEpoch / 1000))
                        .toInt()
                        .toString(),
              ),
            ),
            RxChatData(
              ChatData(
                groupId: '',
                chatId: 'chatId',
                repId: 'repId',
                resource: [
                  Resource(
                    urlOrigin: '',
                  )
                ],
                content: 'content',
                createTime: ((DateTime(2000).microsecondsSinceEpoch / 1000))
                    .toInt()
                    .toString(),
                userId: '',
                username: 'username',
                userAvatar: 'userAvatar',
                replyResource: [],
                replyCreateTime:
                    ((DateTime(2000).microsecondsSinceEpoch / 1000))
                        .toInt()
                        .toString(),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> onLoading() async {
    //Call api and add all
    try {
      listChat.update((val) {
        val?.addAll(
          [],
        );
      });
      final bool outOfData = true;
      if (outOfData) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
    } catch (e) {
      refreshController.loadFailed();
    }
  }

  Future<void> sendMessage() async {
    //api
    // _insertChat(data);
    textController.clear();
  }

  Future<void> deleteMessage(RxChatData data) async {
    //api
    data.update((val) {
      val?.isDelete = true;
    });
  }

  void _insertChat(RxChatData data) {
    listChat.update((val) {
      val?.insert(0, data);
    });

    Future.delayed(const Duration(milliseconds: 50), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(0,
            duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
      }
    });
  }

  Future<void> selectImageFromLib() async {
    if (await PermissionUtils.photoPermission) {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      if (image == null) return;
      final file = File(image.path);
      // _insertChat(data);

    } else {
      AppDialogs.showDialog(
        description: 'No access to image library',
        onConfirmBtnPressed: () => Get.back(),
      );
    }
  }

  Future<void> takePhoto() async {
    if (await PermissionUtils.checkCameraPermission) {
      final ImagePicker _picker = ImagePicker();
      final image = await _picker.pickImage(source: ImageSource.camera);
      if (image == null) return;
      final file = File(image.path);
      // _insertChat(data);

    } else {
      AppDialogs.showDialog(
        description: 'No camera access',
        onConfirmBtnPressed: () => Get.back(),
      );
    }
  }

  Future<void> pickFile() async {
    if (await PermissionUtils.checkStoragePermission) {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'doc', 'xlsx', 'docx', 'txt'],
      );
      if (result?.files.single.path != null) {
        final File file = File(result!.files.single.path!);

        
        // _insertChat(data);

      }
    } else {
      AppDialogs.showDialog(
        description: 'No storage access',
        onConfirmBtnPressed: () => Get.back(),
      );
    }
  }

  Future<void> downloadFile(RxChatData data) async {
    if (data.resource.isNotEmpty && data.resource.first.urlOrigin != null) {
      final String dir = (await getApplicationDocumentsDirectory()).path;
      final taskId = await FlutterDownloader.enqueue(
        url: data.resource.first.urlOrigin!,
        headers: {},
        savedDir: dir,
        showNotification: false,
        openFileFromNotification: false,
        fileName: data.resource.first.name,
      );

      data.update((val) {
        val?.filePath = '$dir/${data.resource.first.name}';
        val?.taskId = taskId;
        val?.downloadTaskStatus = DownloadTaskStatus.running;
        val?.downloadProgress = 0;
      });
    }
  }

  @override
  void dispose() {
    textController.dispose();
    focusInputMessageField.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
