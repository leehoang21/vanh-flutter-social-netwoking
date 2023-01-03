import 'package:commons/commons.dart';
import 'package:commons/os_info/os_info.dart';
import 'package:finplus/models/login_info_data.dart';
import 'package:finplus/providers/api_path.dart';
import 'package:finplus/utils/types.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '/base/base.dart';

enum LoginType {
  facebook,
  google,
  apple,
  account,
}

class AuthProvider extends BaseNetWork {
  Future<LoginInfoData?> login({required final LoginType type}) async {
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
        decoder: LoginInfoData.fromJson,
        body: {
          ...params,
          'accessToken': fbRes.accessToken?.token,
        }.json,
      );

      final res = await sendRequest<LoginInfoData>(req);

      return res;
    } else {
      logW(fbRes.status);
      return null;
    }
  }
}
