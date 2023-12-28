import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobdev_final_app/data/firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthenticationDatasource {
  Future<void> register(String email, String password, String PasswordConfirm);
  Future<void> login(String email, String password);
  Future<UserCredential?> signInWithGoogle();
}

class AuthenticationRemote extends AuthenticationDatasource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(), password: password.trim());
  }

  @override
  Future<void> register(
      String email, String password, String PasswordConfirm) async {
    if (PasswordConfirm == password) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((value) {
        Firestore_Datasource().CreateUser(email, password);
      });
    }
  }

  @override
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        return await _auth.signInWithCredential(credential);
      } else {
        return null; // Handle null user or cancellation
      }
    } catch (error) {
      print('Error signing in with Google: $error');
      return null; // Handle sign-in errors
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut(); // Sign out from Firebase Auth
      await _googleSignIn.signOut(); // Disconnect from Google Sign-In
    } catch (error) {
      print('Error signing out: $error');
      // Handle sign-out errors if needed
    }
  }
}
