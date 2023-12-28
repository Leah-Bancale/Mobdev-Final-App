import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobdev_final_app/const/colors.dart';

class Advice {
  final String advice;

  Advice({required this.advice});

  factory Advice.fromJson(Map<String, dynamic> json) {
    return Advice(advice: json['slip']['advice'] ?? 'No advice available');
  }

  static Future<Advice> fetchAdvice() async {
    final response =
        await http.get(Uri.parse('https://api.adviceslip.com/advice'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return Advice.fromJson(data);
    } else {
      throw Exception('Failed to load advice');
    }
  }
}

class AdviceScreen extends StatefulWidget {
  @override
  _AdviceScreenState createState() => _AdviceScreenState();
}

class _AdviceScreenState extends State<AdviceScreen> {
  late Future<Advice> futureAdvice;

  @override
  void initState() {
    super.initState();
    futureAdvice = Advice.fetchAdvice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Advice',
          style: TextStyle(color: Colors.white),
        ),
        leading: Icon(Icons.lightbulb_outline, color: Colors.white),
        backgroundColor: custom_green,
      ),
      body: Center(
        child: FutureBuilder<Advice>(
          future: futureAdvice,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BoxedMessage(
                      message: snapshot.data?.advice ?? 'No advice available',
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class BoxedMessage extends StatelessWidget {
  final String message;

  const BoxedMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: custom_green,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lightbulb_outline,
            size: 80,
            color: Colors.yellow,
          ),
          SizedBox(height: 20),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
