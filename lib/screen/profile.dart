import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobdev_final_app/const/colors.dart';
import 'package:mobdev_final_app/data/auth_data.dart';

class Profile extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white), // Changing app bar font color
        ),
        backgroundColor: custom_green, // Changing app bar background color
      ),
      body: Center(
        child: user != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: custom_green,
                    radius: 50,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    user?.email ?? 'Email not available',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      AuthenticationRemote().signOut();
                      // You may navigate to another screen after logout
                    },
                    child: Text('Logout'),
                  ),
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
