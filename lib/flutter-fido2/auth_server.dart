// ignore_for_file: unused_import, avoid_print

import 'dart:convert';
import 'dart:math';

import 'package:crypton/crypton.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'api_service.dart';

/// A helper class that lets you communicate with your server if you
/// decide to let the plugin handle networking for you. It can
/// alternatively stick to authenticating through the [Fido2Flutter] class.
/// It is used in conjunction with the Api Service Class
class AuthServer {
  // Create Local storage
  final _storage = const FlutterSecureStorage();

  /// The base Url of your server. This is the endpoint that is
  /// fed with all requests if you choose to let the plugin handle
  /// your networking.
  var baseUrl = 'https://fido.silbaka.com';

  // Create online  storage
  // final _storage = ApiService();

  AuthServer();

  /// create a registration request
  Future<Map<String, dynamic>> registrationRequest(
      {required String userId}) async {
    if (userId == '')
      throw PlatformException(
          code: 'User_Name_Cannot_Be_Blank',
          message: 'Username cannot be blank');
    final String challenge = _generateChallenge();

    final _data = (await _storage.read(key: userId)) ?? '{"credentials":[]}';
    print('sent data:$_data');
    final List credentials = [
      {
        'credentialId': 'CBq-k4vr0iUHtFBYsE525HB_mB0LrgbF',
        'publicKey': 'ApnF4oRJz+X/b8KoXvgEvVpSuDxCcbz+ojjDkICvk7WY'
      },
      {
        'credentialId': 'lXPpBK.wGi62zFp0l2fTbp9q81djieOy',
        'publicKey': 'A6fuLcId/Y89o6Nc19MXP0QXCSFGw8p5m6Ew0kX9s540'
      }
    ];
    // final List credentials = json.decode(_data)['credentials'];
    final List ids = [];
    for (final item in credentials) {
      ids.add(item['credentialId']);
    }
    try {
      // ignore: unused_local_variable
      final writeResult = await _storage.write(
          key: 'RequestChallengeFor$userId', value: challenge);
    } catch (e) {
      print(e.toString());
    }
    // print('sent write result:$writeResult');

    print({'challenge': challenge, 'credentials': ids});
    return {'challenge': challenge, 'credentials': ids};
  }

  Future<Map<String, dynamic>> signingRequest({required String userId}) async {
    if (userId == '')
      throw PlatformException(
          code: 'User_Name_Cannot_Be_Blank',
          message: 'Username cannot be blank');
    final String challenge = _generateChallenge();

    // ignore: unused_local_variable
    final _data = (await _storage.read(key: userId)) ?? '{"credentials":[]}';
    // final List credentials = json.decode(_data)['credentials'];
    final List credentials = [
      {
        'credentialId': 'CBq-k4vr0iUHtFBYsE525HB_mB0LrgbF',
        'publicKey': 'ApnF4oRJz+X/b8KoXvgEvVpSuDxCcbz+ojjDkICvk7WY'
      },
      {
        'credentialId': 'lXPpBK.wGi62zFp0l2fTbp9q81djieOy',
        'publicKey': 'A6fuLcId/Y89o6Nc19MXP0QXCSFGw8p5m6Ew0kX9s540'
      }
    ];
    final List<String> ids = [];
    for (final item in credentials) {
      ids.add(item['credentialId']);
    }

    await _storage.write(key: 'RequestChallengeFor$userId', value: challenge);

    print({'challenge': challenge, 'credentials': ids});
    return {'challenge': challenge, 'credentials': ids};
  }

  Future<String> confirmSignIn(
      {required String userId,
      required String credentialId,
      required String signedChallenge}) async {
    try {
      // ignore: unused_local_variable
      final _data = (await _storage.read(key: userId)) ?? '{"credentials":[]}';
      // final List credentials = json.decode(_data)['credentials'];
      final List credentials = [
        {
          'credentialId': 'CBq-k4vr0iUHtFBYsE525HB_mB0LrgbF',
          'publicKey': 'ApnF4oRJz+X/b8KoXvgEvVpSuDxCcbz+ojjDkICvk7WY'
        },
        {
          'credentialId': 'lXPpBK.wGi62zFp0l2fTbp9q81djieOy',
          'publicKey': 'A6fuLcId/Y89o6Nc19MXP0QXCSFGw8p5m6Ew0kX9s540'
        }
      ];
      String publicKey = '';
      for (final item in credentials) {
        if (item['credentialId'] != credentialId) continue;
        publicKey = item['publicKey'];
        break;
      }
      if (publicKey == '')
        return 'Sorry, Login Unsuccessful. please try again or register.';
      final bool isValid =
          await _validateChallenge(userId, publicKey, signedChallenge);
      if (!isValid) {
        return 'Sorry, Login Unsuccessful.';
      }
      print('AKBR IT IS VALID');

      return 'Successfully Logged in. User Id:$userId';
    } on PlatformException catch (e) {
      return 'error occured: ${e.message}';
    }
  }

  Future<String> storeCredential(
      {required String userId,
      required String credentialId,
      required String signedChallenge,
      required String publicKey}) async {
    try {
      final bool isValid =
          await _validateChallenge(userId, publicKey, signedChallenge);
      if (!isValid) {
        return 'false';
      }
      print('AKBR IT IS VALID');

      final _data = (await _storage.read(key: userId)) ?? '{"credentials":[]}';
      final List credentials = json.decode(_data)['credentials'];
      credentials.add({'credentialId': credentialId, 'publicKey': publicKey});

      final String storeData =
          json.encode({'userId': userId, 'credentials': credentials});
      await _storage.write(key: userId, value: storeData);

      return 'Storage Successful. User Id: $userId';
    } on PlatformException catch (e) {
      return 'error occured: ${e.message}';
    }
  }

  Future<bool> _validateChallenge(
      String userId, String publicKey, String signedChallenge) async {
    final String challenge =
        await _storage.read(key: 'RequestChallengeFor$userId') ??
            _generateChallenge();
    await _storage.delete(key: 'RequestChallengeFor$userId');

    final List<int> challengeList = challenge.codeUnits;
    final Uint8List challengeUnit8 = Uint8List.fromList(challengeList);

    final List<int> singedList = signedChallenge.codeUnits;
    final Uint8List singedUnit8 = Uint8List.fromList(singedList);

    return ECPublicKey.fromString(publicKey)
        .verifySHA256Signature(challengeUnit8, singedUnit8);
  }

  String _generateChallenge([int length = 64]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }
}
