import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/register/register.dart';
import 'package:finplus/models/user_model.dart';
import 'package:finplus/services/auth_service.dart';
import 'package:finplus/utils/styles.dart';
import 'package:flutter/material.dart';

import '/widgets/button/button.dart';
import '/widgets/text_input/text_input.dart';
import '../../../flutter-fido2/flutter_fido2.dart';
import '../../../routes/finplus_routes.dart';
import 'login_controller.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.t;
    final AuthService _auth = AuthService();
    final fido2 = FlutterFido2();

    return GetBuilder<LoginController>(
      builder: (c) => Scaffold(
        backgroundColor: theme.primary_01,
        body: ListView(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 150,
            ),
            Spaces.box42,
            Text(
              'Đăng nhập',
              style: TextDefine.H1_B.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Spaces.box24,
            Padding(
              padding: Spaces.h16,
              child: TextInput(controller: c.email),
            ),
            Spaces.box16,
            Padding(
              padding: Spaces.h16,
              child: TextInput(controller: c.password),
            ),
            Spaces.box16,
            Padding(
              padding: Spaces.h16,
              child: Button(
                type: ButtonType.gradient,
                onPressed: () async {
                  final UserModel result =
                      await _auth.signInWithEmailAndPassword(
                    c.email.value.text,
                    c.password.value.text,
                  );
                  if (result == null) {
                    print('Sign in failed');
                  } else {
                    print('Sign in success');
                    print(result.uid);
                    Get.offAllNamed(Routes.home);
                  }
                },
                child: const Text('Login Email'),
              ),
            ),
            Spaces.box16,
            Padding(
              padding: Spaces.h16,
              child: Button(
                type: ButtonType.gradient,
                onPressed: () async {
//This returns a SigningResult
                  try {
                    final SigningResult resultFido = await fido2.signChallenge(
                      challenge:
                          '3820435cf5f79ca903a426a6e4497556fd387194c8af563627e893eb3614ad7c7b05f9e21ffa1e58b0544613cc974c5def3fbeb98d6fae60deb6f5d975744c10', // comes from your server
                      allowCredentials: [
                        '_EEKfdQ3emsikn0xJUNwDaqGm.QMJVuh',
                        'J8N-LfF32GsDz.QTYVZy5yd97zdILA2b',
                      ],
                      userId: '20',
                      rpDomain: 'http://fido.local',
                      options: const AuthenticationOptions(
                        useErrorDialogs:
                            true, // use error dialogs that are inbuilt
                        biometricOnly:
                            true, //use only in-built biometric authenticator
                      ),
                    );
//you can access and send this information on to your server for verification of the signed challenge.
                    print(resultFido.credentialId);
                    print(resultFido.signedChallenge);
                    print(resultFido.userId);
                  } catch (_) {}

                  final UserModel result =
                      await _auth.signInWithEmailAndPassword(
                    c.email.value.text,
                    c.password.value.text,
                  );
                  if (result == null) {
                    print('Sign in failed');
                  } else {
                    print('Sign in success');
                    print(result.uid);
                    Get.offAllNamed(Routes.home);
                  }
                },
                child: const Text('Login fido'),
              ),
            ),
            // Padding(
            //   padding: Spaces.h16,
            //   child: Button(
            //     type: ButtonType.gradient,
            //     onPressed: () async {
            //       final RegistrationResult resultFido = await fido2.register(
            //         challenge: 'Hieu2',
            //         rpDomain: 'http://fido.local',
            //         userId: '30',
            //       );
            //       print(resultFido.credentialId.toString());

            //       print(resultFido.signedChallenge.toString());

            //       print(resultFido.publicKey.toString());
            //     },
            //     child: const Text('Đăng ký'),
            //   ),
            // ),

            Spaces.box42,
            Padding(
              padding: Spaces.h16,
              child: Button(
                type: ButtonType.gradient,
                onPressed: () {
                  Get.to(() => const Register());
                },
                child: const Text('Đăng ký'),
              ),
            ),
            Spaces.box16,
          ],
        ),
      ),
    );
  }
}
