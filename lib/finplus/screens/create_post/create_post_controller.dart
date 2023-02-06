import 'package:commons/commons.dart';

import '../../../utils/utils.dart';

class CreatePostController extends GetxController {
  late final Rx<List<dynamic>> images;

  @override
  void onInit() {
    images = Rx([]);
    super.onInit();
  }

  void pickImage() {
    Utils.pickMultipleImages(images);
  }
}
