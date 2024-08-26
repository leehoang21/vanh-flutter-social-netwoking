import '/base/base.dart';
import '/models/login_info_data.dart';
import '/providers/api_path.dart';

enum LoginType {
  facebook,
  google,
  apple,
  admin,
}

class AuthProvider extends BaseNetWork {
  Future<LoginInfoData?> login({
    required final LoginType type,
    String? username,
    String? password,
  }) async {
    final Map<String, dynamic> params = {
      'clientId': 'complex01',
      'clientSecret': 'complex01',
      'username': '0378060781',
      'password': '12345678',
      'deviceUUID': 'xxxx123',
      'platform': 'WEB',
    };

    final ApiResponse<LoginInfoData?>? res;

    switch (type) {
      case LoginType.admin:
        res = await _userLogin(params, username, password);
        break;

      default:
        res = null;
    }

    if (res != null) {
      if (res.success) {
        return res.body;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<ApiResponse<LoginInfoData?>?> _userLogin(
    Map<String, dynamic> params,
    String? username,
    String? password,
  ) {
    final ApiRequest req = ApiRequest(
      path: ApiPath.login,
      method: METHOD.POST,
      auth: false,
      body: {...params, 'username': '0378060781', 'password': '12345678'},
    );

    final res = sendRequest(
      req,
      decoder: LoginInfoData.fromJson,
    );

    return res;
  }
}
