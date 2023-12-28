import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
        title: Text('Advice'),
        leading: Icon(Icons.lightbulb_outline), // Adding a bulb icon
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
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.lightbulb_outline,
                            size: 100,
                            color: Colors.yellow,
                          ),
                          SizedBox(height: 20),
                          Text(
                            snapshot.data?.advice ?? 'No advice available',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
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
