import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);
  bool connecting = false;
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  void signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> signIn({String email, String password}) async {
    try {
      connecting = true;
      notifyListeners();
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      connecting = false;
      notifyListeners();
      return "Signed In.";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp({String email, String password}) async {
    try {
      connecting = true;
      notifyListeners();
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      connecting = false;
      notifyListeners();
      print('User Signed in');
      return "User signed up successfully.";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
