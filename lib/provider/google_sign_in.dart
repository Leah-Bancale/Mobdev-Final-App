import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future<void> googleLogin() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      notifyListeners();
    } catch (error) {
      print(error);
      // Handle error as needed
    }
  }

  Future<void> logout() async {
    try {
      await _googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
      notifyListeners();
    } catch (error) {
      print(error);
      // Handle error as needed
    }
  }
}
