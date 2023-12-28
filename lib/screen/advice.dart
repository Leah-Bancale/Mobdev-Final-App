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
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    futureAdvice = Advice.fetchAdvice();
  }

  void reloadAdvice() {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      // Simulate the time it takes to fetch new advice (adjust the duration as needed)
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          futureAdvice = Advice.fetchAdvice();
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Advice'),
        leading: Icon(Icons.lightbulb_outline),
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
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: reloadAdvice,
                            style: ElevatedButton.styleFrom(
                              primary: custom_green,
                              onPrimary: Colors.white,
                              padding: EdgeInsets.all(15),
                            ),
                            child: isLoading
                                ? CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  )
                                : Text('Get Another Quote'),
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
