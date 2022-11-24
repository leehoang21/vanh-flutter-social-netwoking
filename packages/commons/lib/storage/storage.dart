import 'dart:convert';

import 'package:commons/commons.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class Storage {
  late final Box box;

  static late final Storage _instance;

  static Future<Storage> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    String? keyEncrpt = await secureStorage.read(key: 'encrpt');
    keyEncrpt ??= const Uuid().v4();
    secureStorage.write(key: 'encrpt', value: keyEncrpt);

    String? encrpt = await secureStorage.read(key: keyEncrpt);

    if (encrpt == null) {
      final String key = base64UrlEncode(Hive.generateSecureKey());
      await secureStorage.write(key: keyEncrpt, value: key);
      encrpt = key;
    }

    final encryptionKey = base64Url.decode(encrpt);

    String? boxName = await secureStorage.read(key: 'BoxName');
    boxName ??= const Uuid().v4();
    secureStorage.write(key: 'BoxName', value: boxName);

    final Box box = await Hive.openBox(boxName,
        encryptionCipher: HiveAesCipher(encryptionKey));
    _instance = Storage._internal(box);
    return _instance;
  }

  Storage._internal(this.box);

  static void put<T>(dynamic key, T value) {
    try {
      if (value is ExtendModel) {
        _instance.box.put(key.toString(), json.encode(value.toJson()));
      } else if (value is List<ExtendModel>) {
        _instance.box.put(
            key.toString(), json.encode(value.map((e) => e.toJson()).toList()));
      } else {
        _instance.box.put(key.toString(), value);
      }
    } catch (_) {}
  }

  static void putList<T>(dynamic key, T value) {
    try {
      if (value is List<ExtendModel>) {
        _instance.box.put(
            key.toString(), json.encode(value.map((e) => e.toJson()).toList()));
      } else {
        _instance.box.put(key.toString(), value);
      }
    } catch (_) {}
  }

  static T? get<T>(dynamic key, [T Function(Map data)? decoder]) {
    try {
      final data = _instance.box.get(key.toString());

      if (decoder != null && data != null) {
        return decoder(json.decode(data));
      } else {
        return data;
      }
    } catch (_) {
      return null;
    }
  }

  static List<T>? getList<T>(dynamic key, [T Function(Map data)? decoder]) {
    try {
      final data = _instance.box.get(key.toString());

      if (decoder != null && data != null) {
        return (json.decode(data) as List).map((e) => decoder(e)).toList();
      } else {
        return data;
      }
    } catch (_) {
      return null;
    }
  }

  static void delete(dynamic key) {
    _instance.box.delete(key.toString());
  }
}
