import 'package:commons/commons.dart';
import 'package:finplus/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class SelectImageMbsController extends GetxController {
  final Function(String imagePath)? onSelected;
  SelectImageMbsController({
    this.onSelected,
  });

  Future<void> imgFromGallery() async {
    final image = await Utils.pickImage(ImageSource.gallery);
    if (image == null) return;
    onSelected?.call(image);
    Get.back();
  }

  Future<void> imgFromCamera() async {
    final image = await Utils.pickImage(ImageSource.camera);
    if (image == null) return;
    onSelected?.call(image);
    Get.back();
  }
}
