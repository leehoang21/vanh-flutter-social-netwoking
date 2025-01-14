// ignore_for_file: deprecated_member_use, unused_catch_clause, prefer_single_quotes

library flutter_fido2;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypton/crypton.dart';
import 'package:finplus/services/database.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:local_auth_windows/local_auth_windows.dart';

import 'registration_result.dart';
import 'signing_result.dart';

export 'package:local_auth_ios/local_auth_ios.dart';

export 'api_service.dart';
export 'auth_server.dart';
export 'registration_result.dart';
export 'signing_result.dart';

class FlutterFido2 {
  // ignore: unused_element
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  final LocalAuthentication auth = LocalAuthentication();

  // Create storage
  final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  /// Initiates the FIDO registration process.
  ///
  /// This launches the FIDO client which authenticates the user associated with [userId]
  /// via lock screen (which may have biometric or PIN methods) or
  /// even external authenticators.
  ///
  /// The [options.rpDomain] and [options.rpName] describe the Relying Party's
  /// domain and name.
  /// See: https://www.w3.org/TR/webauthn/#webauthn-relying-party
  ///
  /// e.g.
  /// rpDomain: fido.silbaka.com
  /// rpName: Webauthn Demo Server
  ///
  /// Note that the RP domain must be hosting an assetlinks.json file.
  /// See: https://developers.google.com/identity/fido/android/native-apps#interoperability_with_your_website
  ///
  /// The [challenge] is used validation purposes by the WebAuthn server.
  ///
  /// [options.coseAlgoValue] is the COSE identifier for the cryptographic algorithm that will be
  /// used by the authenticator for keypair generation.
  /// See: https://www.iana.org/assignments/cose/cose.xhtml
  ///
  /// The method returns a [RegistrationResult] future that is completed after the
  /// user completes the authentication process
  Future<RegistrationResult> register({
    required String challenge,
    List excludeCredentials = const [],
    required String userId,
    required String rpDomain,
    String rpName = '',
    AuthenticationOptions options = const AuthenticationOptions(
        useErrorDialogs: true,
        stickyAuth: true,
        biometricOnly: true,
        sensitiveTransaction: true),
  }) async {
    options = (Platform.isWindows)
        ? const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
          )
        : options;
    rpName = (rpName == '') ? rpDomain : rpName;
    final String localizedReason = 'Register on $rpName as  $userId ';
    RegistrationResult result;
    String? data;
    final bool valid = await auth.authenticate(
      localizedReason: localizedReason,
      options: options,
    );
    if (!valid) {
      throw PlatformException(
          code: 'Authentication_failed',
          message: 'Authentication Failed. please try again');
    }

    for (final currentId in excludeCredentials) {
      data = await storage.read(key: currentId);

      if (data != null)
        throw PlatformException(
            code: 'USER_EXISTS',
            message:
                'Sorry, this User already has this authenticator registered.');
    }

    final ECKeypair ecKeypair = ECKeypair.fromRandom();

    final String credentialId = _generateCredentialId();

    final String signedChallenge =
        ecKeypair.privateKey.createSignature(challenge);

    result = RegistrationResult(
        credentialId, signedChallenge, ecKeypair.publicKey.toString());

    final Map savedCreds = {
      'credentialId': credentialId,
      'privateKey': ecKeypair.privateKey.toString(),
      'rpDomain': rpDomain,
      'rpName': rpName,
      'userId': userId
    };
    // await storage.deleteAll();

    await storage.write(key: credentialId, value: json.encode(savedCreds));
    DatabaseService(uid: 'sDEwn27aKHelKHGXOlh7KR1Q7E22')
        .saveCredential(credentialId, ecKeypair.publicKey.toString());
    return result;
  }

  /// Begins the FIDO signing process.
  ///
  /// This launches the FIDO client which authenticates the user whose credentials
  /// were previously registered and are associated with the credential identifier
  /// [allowCredentials]. This [allowCredentials] is a comma seperated list of credential ids,
  /// and should match the one produced in the registration
  /// phase for the same user ([RegistrationResult.credentialId]).
  ///
  ///
  /// The [challenge] is signed by the private key that the FIDO client created
  /// during registration. The [SigningResult.signedChallenge] produced will be used
  /// for user verification purposes.
  ///
  /// The [rpDomain] describes the Relying Party's domain.
  /// e.g. rpDomain: webauthn-demo-server.com
  /// See: https://www.w3.org/TR/webauthn/#webauthn-relying-party
  ///
  /// Note that the RP domain must be hosting an assetlinks.json file.
  /// See: https://developers.google.com/identity/fido/android/native-apps#interoperability_with_your_website
  ///
  /// The method returns a [SigningResult] future that is completed after the
  /// user completes the authentication process.
  Future<SigningResult> signChallenge({
    required String challenge,
    required List<String> allowCredentials,
    required String rpDomain,
    String userId = '',
    AuthenticationOptions options = const AuthenticationOptions(
        useErrorDialogs: true, stickyAuth: true, biometricOnly: true),
  }) async {
    options = (Platform.isWindows)
        ? const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
          )
        : options;
    final String reasonEnd = (userId == '') ? '' : ' as $userId';
    final String localizedReason = "Log in to  $rpDomain$reasonEnd";
    final SigningResult result;
    String? data;
    var i = -1;

    final bool valid = await auth.authenticate(
        localizedReason: localizedReason, options: options);
    if (!valid) {
      throw PlatformException(
          code: 'Authentication_failed',
          message: 'Authentication Failed. please try again');
    }

    for (final currentId in allowCredentials) {
      data = await storage.read(key: currentId);
      i = i + 1;
      if (data != null) break;
    }

    if (data == null) {
      throw PlatformException(
          code: 'NO_CREDENTIAL_FOUND',
          message: 'Sorry, Credential not found. Have you registered?');
    }

    final Map savedCreds = json.decode(data);
    final ECPrivateKey privateKey =
        ECPrivateKey.fromString(savedCreds['privateKey']);
    final String signedChallenge = privateKey.createSignature(challenge);

    result = SigningResult(
        allowCredentials[i], signedChallenge, savedCreds['userId']);
    return result;
  }

  /// Check if Biometrics are supported
  Future<bool> checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
    }
    return canCheckBiometrics;
  }

  /// Get available authentication means
  Future<List<BiometricType>> getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
    }

    return availableBiometrics;
  }

  Future<bool> authenticate(
      {required String localizedReason,
      Iterable<AuthMessages> authMessages = const <AuthMessages>[
        IOSAuthMessages(),
        AndroidAuthMessages(),
        WindowsAuthMessages()
      ],
      AuthenticationOptions options = const AuthenticationOptions()}) {
    Future<bool> result;
    result = auth.authenticate(
        localizedReason: localizedReason,
        authMessages: authMessages,
        options: options);
    return result;
  }

  /// Stop Authentication for any reason
  Future<bool> stopAuthentication() {
    return auth.stopAuthentication();
  }

  /// Generates a cryptographically secure random credentialID, to be included in a credential request.
  String _generateCredentialId([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }
}
