// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobdev_final_app/const/colors.dart';
import 'package:mobdev_final_app/data/firestore.dart';

class Add_creen extends StatefulWidget {
  const Add_creen({super.key});

  @override
  State<Add_creen> createState() => _Add_creenState();
}

class _Add_creenState extends State<Add_creen> {
  final title = TextEditingController();
  final subtitle = TextEditingController();

  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  int indexx = 0;
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColors,
      appBar: AppBar(
        backgroundColor: custom_green,
        title: Text(
          'Add Task',
          style: TextStyle(color: Colors.white), 
        ),
        centerTitle: true, 
        elevation: 0, 
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            title_widgets(),
            SizedBox(height: 20),
            subtitle_widgets(),
            SizedBox(height: 20),
            imagess(),
            SizedBox(height: 20),
            button()
          ],
        ),
      ),
    );
  }

  Widget button() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: custom_green,
            minimumSize: Size(150, 48),
          ),
          onPressed: () {
            Firestore_Datasource().AddNote(subtitle.text, title.text, indexx);
            Navigator.pop(context);
          },
          child: Text(
            'Add Task',
            style: TextStyle(color: Colors.white), // Set text color to white
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 254, 255, 245),
            minimumSize: Size(150, 48),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.black), // Set text color to white
          ),
        ),
      ],
    );
  }

Container imagess() {
  List<String> titles = ['Work', 'Home', 'Leisure', 'Misc'];

  return Container(
    height: 180,
    child: ListView.builder(
      itemCount: 4,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              indexx = index;
            });
          },
          child: Padding(
            padding: EdgeInsets.only(left: index == 0 ? 7 : 0),
            child: Container(
              width: 140,
              margin: EdgeInsets.all(8),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 120, // Set the desired height for the images
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: indexx == index ? custom_green : Colors.grey,
                      ),
                    ),
                    child: Image.asset(
                      'images/${index}.png',
                      fit: BoxFit.cover, // Use BoxFit.cover for uniform sizing
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    titles[index],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

  Widget title_widgets() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          controller: title,
          focusNode: _focusNode1,
          style: TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
            labelText: 'Title', // Add the label for the title field
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            hintText: 'Enter title',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color(0xffc5c5c5),
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: custom_green,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

Padding subtitle_widgets() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: SingleChildScrollView(
        child: TextField(
          maxLines: null, // Allow unlimited lines
          controller: subtitle,
          focusNode: _focusNode2,
          style: TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
            labelText: 'Details',
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            hintText: 'Enter details',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color(0xffc5c5c5),
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: custom_green,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

}
