import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobdev_final_app/data/firestore.dart';
// import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthenticationDatasource {
  Future<void> register(String email, String password, String PasswordConfirm);
  Future<void> login(String email, String password);
  // Future<UserCredential?> signInWithGoogle();
}

class AuthenticationRemote extends AuthenticationDatasource {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

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
        Firestore_Datasource().CreateUser(email);
      });
    }
  }


  // @override
  // Future<UserCredential?> signInWithGoogle() {
  //   // complete the code for the signInWithGoogle 
  // }
}
