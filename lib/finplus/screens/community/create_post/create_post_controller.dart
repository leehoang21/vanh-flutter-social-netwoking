import 'package:commons/commons.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostController extends GetxController {
  late final Rx<List<dynamic>> images;

  @override
  void onInit() {
    images = Rx([]);
    super.onInit();
  }

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();

    final pickedImages =
        await _picker.pickMultiImage(requestFullMetadata: false);

    if (pickedImages.isNotEmpty) {
      images.update((val) {
        val?.addAll(pickedImages.map((e) => e.path));
      });
    }
  }
}
