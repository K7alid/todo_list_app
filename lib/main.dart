import 'package:flutter/material.dart';
import 'package:todo_list_app/ui/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.lightBlueAccent,
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
