import 'dart:io';

import 'package:commons/commons.dart';
import 'package:image_picker/image_picker.dart';

class SelectImageMbsController extends GetxController {
  final Function(File image)? onSelected;
  SelectImageMbsController({
    this.onSelected,
  });
  late final ImagePicker _picker;

  @override
  void onInit() {
    _picker = ImagePicker();
    super.onInit();
  }

  Future<void> imgFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) return;
    final file = File(image.path);
    onSelected?.call(file);
    Get.back();
  }

  Future<void> imgFromCamera() async {
    final image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) return;
    final file = File(image.path);
    onSelected?.call(file);
  }
}
