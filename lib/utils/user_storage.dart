import 'dart:convert';

import 'package:commons/commons.dart';
import 'package:finplus/utils/app_logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';

class UserStorage {
  late final Box box;

  static UserStorage? _instance;

  static Future<UserStorage> init(String id) async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    const FlutterSecureStorage secureStorage = FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true));
    String? keyEncrpt = await secureStorage.read(key: id);
    keyEncrpt ??= const Uuid().v4();
    secureStorage.write(key: id, value: keyEncrpt);

    String? encrpt = await secureStorage.read(key: keyEncrpt);

    if (encrpt == null) {
      final String key = base64UrlEncode(Hive.generateSecureKey());
      await secureStorage.write(key: keyEncrpt, value: key);
      encrpt = key;
    }

    final encryptionKey = base64Url.decode(encrpt);

    final Box box =
        await Hive.openBox(id, encryptionCipher: HiveAesCipher(encryptionKey));
    return UserStorage._internal(box);
  }

  static void setUserStorage(UserStorage? storage) {
    _instance = storage;
  }

  UserStorage._internal(this.box);

  static void put<T>(dynamic key, T value) {
    try {
      if (_instance != null) {
        if (value is ExtendModel) {
          _instance!.box.put(key.toString(), json.encode(value.toJson()));
        } else if (value is List<ExtendModel>) {
          _instance!.box.put(key.toString(),
              json.encode(value.map((e) => e.toJson()).toList()));
        } else {
          _instance!.box.put(key.toString(), value);
        }
      }
    } catch (_, stackTrace) {
      logE(_, stackTrace);
    }
  }

  static void putList<T>(dynamic key, T value) {
    try {
      if (_instance != null) {
        if (value is List<ExtendModel>) {
          _instance!.box.put(key.toString(),
              json.encode(value.map((e) => e.toJson()).toList()));
        } else {
          _instance!.box.put(key.toString(), value);
        }
      }
    } catch (_, stackTrace) {
      logE(_, stackTrace);
    }
  }

  static T? get<T>(dynamic key, [T Function(Map data)? decoder]) {
    try {
      if (_instance != null) {
        final data = _instance!.box.get(key.toString());

        if (decoder != null && data != null) {
          return decoder(json.decode(data));
        } else {
          return data;
        }
      } else
        return null;
    } catch (_, stackTrace) {
      logE(_, stackTrace);
      return null;
    }
  }

  static List<T>? getList<T>(dynamic key, [T Function(Map data)? decoder]) {
    try {
      if (_instance != null) {
        final data = _instance!.box.get(key.toString());

        if (decoder != null && data != null) {
          return (json.decode(data) as List).map((e) => decoder(e)).toList();
        } else {
          return data;
        }
      } else
        return null;
    } catch (_, stackTrace) {
      logE(_, stackTrace);
      return null;
    }
  }

  static void delete(dynamic key) {
    if (_instance != null) {
      _instance!.box.delete(key.toString());
    }
  }
}
