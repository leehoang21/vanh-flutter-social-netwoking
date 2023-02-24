import 'package:commons/commons.dart';

class LoginInfoData extends ExtendModel {
  late String refreshToken;
  late String accessToken;
  late String username;
  late UserInfo userInfo;
  late bool trustDevice;
  late bool useSmartOtp;

  LoginInfoData({
    this.refreshToken = '',
    this.accessToken = '',
    this.username = '',
    required this.userInfo,
    this.trustDevice = false,
    this.useSmartOtp = false,
  });

  LoginInfoData.fromJson(Map<dynamic, dynamic> json) {
    refreshToken = json['refreshToken'] ?? '';
    accessToken = json['accessToken'] ?? '';
    username = json['username'] ?? '';
    userInfo = UserInfo.fromJson(json['userInfo'] ?? {});
    trustDevice = json['trustDevice'] ?? false;
    useSmartOtp = json['useSmartOtp'] ?? false;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['refreshToken'] = refreshToken;
    data['accessToken'] = accessToken;
    data['username'] = username;
    data['userInfo'] = userInfo.toJson();
    data['trustDevice'] = trustDevice;
    data['useSmartOtp'] = useSmartOtp;
    return data.json;
  }
}

class UserInfo extends ExtendModel {
  late final int id;
  late String avatar;
  late String username;
  late String displayName;
  late String name;
  late String otpPin;
  late String privateKey;
  late bool trustDevice;
  late String email;
  late String phoneNumber;

  UserInfo({
    required this.id,
    this.avatar = '',
    this.username = '',
    this.name = '',
    this.otpPin = '',
    this.privateKey = '',
    this.trustDevice = false,
    this.email = '',
    this.phoneNumber = '',
    this.displayName = '',
  });

  UserInfo.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'] ?? -1;
    avatar = json['avatar'] ?? '';
    username = json['username'] ?? '';
    name = json['name'] ?? '';
    otpPin = json['otpPin'] ?? '';
    privateKey = json['privateKey'] ?? '';
    trustDevice = json['trustDevice'] ?? false;
    email = json['email'] ?? '';
    phoneNumber = json['phoneNumber'] ?? '';
    displayName = json['displayName'] ?? '';
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['avatar'] = avatar;
    data['username'] = username;
    data['name'] = name;
    data['otpPin'] = otpPin;
    data['privateKey'] = privateKey;
    data['trustDevice'] = trustDevice;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['displayName'] = displayName;
    return data.json;
  }
}
