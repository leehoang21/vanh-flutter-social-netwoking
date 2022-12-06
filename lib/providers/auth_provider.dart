import 'package:commons/commons.dart';
import 'package:commons/os_info/os_info.dart';
import 'package:finplus/models/login_info_data.dart';
import 'package:finplus/providers/api_path.dart';
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
    try {
      final Map<String, dynamic> params = {
        'clientId': 'ftl',
        'clientSecret': 'ftl',
        'deviceUUID': OsInfo.uuid,
        'platform': 'MOBILE',
        'grantType': type.name,
      };

      switch (type) {
        case LoginType.facebook:
          return _fbLogin(params);

        default:
          return null;
      }
    } catch (e) {
      logE(e);
      return null;
    }
  }

  Future<LoginInfoData?> _fbLogin(Map<String, dynamic> params) async {
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

      if (res.success) {
        return res.body;
      } else {
        return null;
      }
    } else {
      logW(fbRes.status);
      return null;
    }
  }
}
