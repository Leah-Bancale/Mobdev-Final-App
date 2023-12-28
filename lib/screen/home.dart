import 'package:flutter/material.dart';
import 'package:mobdev_final_app/const/colors.dart';
import 'package:mobdev_final_app/screen/add_note_screen.dart';
import 'package:mobdev_final_app/screen/advice.dart';
import 'package:mobdev_final_app/screen/profile.dart';
import 'package:mobdev_final_app/widgets/stream_note.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _HomeScreen_State();
}

class _HomeScreen_State extends State<Home_Screen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomeTab(),
    AdvicePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColors,
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Add_creen(),
                ));
              },
              backgroundColor: custom_green,
              child: Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
            )
          : null,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.pending_actions),
            label: 'To Do',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Daily Advice',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Stream_note(false),
            Text(
              'Finished Task',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.bold,
              ),
            ),
            Stream_note(true),
          ],
        ),
      ),
    );
  }
}

class AdvicePage extends StatelessWidget {
  @override
   Widget build(BuildContext context) {
    return AdviceScreen(); 
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Profile(); 
  }
}
