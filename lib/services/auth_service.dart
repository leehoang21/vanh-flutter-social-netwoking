import 'package:finplus/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? _userFromFirebaseUser(User? userModel) {
    return userModel != null
        ? UserModel(
            uid: userModel.uid,
          )
        : null;
  }

  UserModel? get user {
    return _userFromFirebaseUser(_auth.currentUser);
  }

  Future signInAnno() async {
    try {
      final UserCredential result = await _auth.signInAnonymously();
      final User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
