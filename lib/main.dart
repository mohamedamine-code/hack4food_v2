import 'package:flutter/material.dart';


import 'package:hack_for_food/pages/HomePage.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  title: 'ZADNA',
  home: HomePage(),
);
  }
}