import 'package:flutter/material.dart';
import 'screens/user_selection_screen.dart';

void main() {
  runApp(const MyApp());
}

class AppData {
  static String? userName;
  static String? userCpf;
  static String? userEmail;
  static String? policeMatricula;
  static String? policeName;
  static List<Map<String, dynamic>> occurrences = [];
  static List<Map<String, dynamic>> messages = [];
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIGOR - Portal do Cidadão',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const UserSelectionScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
