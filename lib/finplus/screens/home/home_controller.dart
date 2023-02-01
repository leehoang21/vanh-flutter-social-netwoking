import 'package:commons/commons.dart';
import 'package:finplus/models/login_info_data.dart';
import 'package:finplus/utils/types.dart';
import 'package:finplus/utils/user_storage.dart';

class HomeController extends GetxController {
  late final Rxn<LoginInfoData> userInfo;

  @override
  void onInit() {
    userInfo = Rxn(Storage.get(KEY.USER_INFO, LoginInfoData.fromJson));
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    UserStorage.setUserStorage(
        await UserStorage.init(userInfo.value?.userInfo.id.toString() ?? '-1'));

    super.onReady();
  }

  @override
  Future<void> onClose() async {
    UserStorage.setUserStorage(await UserStorage.init('-1'));
    super.onClose();
  }
}
