import 'package:commons/commons.dart';
import 'package:commons/os_info/os_info.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '/base/base.dart';
import '/models/login_info_data.dart';
import '/providers/api_path.dart';
import '/utils/types.dart';
import '../utils/app_logger.dart';

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
      'clientId': 'ftl',
      'clientSecret': 'ftl',
      'deviceUUID': OsInfo.uuid,
      'platform': 'MOBILE',
      'grantType': type.name,
    };

    final ApiResponse<LoginInfoData?>? res;

    switch (type) {
      case LoginType.facebook:
        res = await _fbLogin(params);
        break;
      case LoginType.admin:
        res = await _userLogin(params, username, password);
        break;

      default:
        res = null;
    }

    if (res != null) {
      if (res.success) {
        Storage.put(KEY.USER_INFO, res.body);
        return res.body;
      } else {
        res.showNotification();
        return null;
      }
    } else {
      return null;
    }
  }

  Future<ApiResponse<LoginInfoData?>?> _fbLogin(
      Map<String, dynamic> params) async {
    final fbRes = await FacebookAuth.instance.login();

    if (fbRes.status == LoginStatus.success) {
      final ApiRequest req = ApiRequest(
        path: ApiPath.login,
        method: METHOD.POST,
        auth: false,
        body: {
          ...params,
          'accessToken': fbRes.accessToken?.token,
        }.json,
      );

      final res = await sendRequest(
        req,
        decoder: LoginInfoData.fromJson,
      );

      return res;
    } else {
      logW(fbRes.status);
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
      body: {...params, 'username': username, 'password': password},
    );

    final res = sendRequest(
      req,
      decoder: LoginInfoData.fromJson,
      disableRetry: true,
    );

    return res;
  }
}
