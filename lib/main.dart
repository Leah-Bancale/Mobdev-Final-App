import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobdev_final_app/auth/main_page.dart';
import 'package:mobdev_final_app/firebase_options.dart';
import 'package:mobdev_final_app/provider/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '471760942637-ib5ppcf9qm1j0u9sujfj4nj4sifvf332.apps.googleusercontent.com',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Main_Page(),
        ),
      );
}
