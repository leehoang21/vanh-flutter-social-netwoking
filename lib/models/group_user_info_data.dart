class GroupUserInfoData {
  late final int id;
  late String? name;
  late String? displayName;
  late final String userName;
  late String? avatar;

  GroupUserInfoData({
    required this.id,
    this.name = '',
    this.displayName = '',
    required this.userName,
    this.avatar= '',
  });

  GroupUserInfoData.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'] ?? -1;
    name = json['name'] ?? '';
    displayName = json['displayName'] ?? '';
    userName = json['username'] ?? '';
    avatar = json['avatar'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['displayName'] = displayName;
    data['username'] = userName;
    data['avatar'] = avatar;
    return data;
  }
}
