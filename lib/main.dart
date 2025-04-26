import 'package:flutter/material.dart';
import 'package:hack_for_food/pages/user_home_page.dart';
import 'package:hack_for_food/test_widget/donner_Type_user.dart';

void main() async {
  // Initialize Flutter bindings
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase (uncomment when ready)
  // await Firebase.initializeApp();
  
  runApp(const ZADNAApp());
}

class ZADNAApp extends StatelessWidget {
  const ZADNAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZADNA',
      debugShowCheckedModeBanner: false,
      theme: _buildAppTheme(),
      darkTheme: _buildDarkTheme(),
      home: const DonorTypePage(),
      routes: {
        // Define your routes here for better navigation management
        '/home': (context) => const UserHomePage(),
        // Add other routes as needed
      },
    );
  }

  ThemeData _buildAppTheme() {
    return ThemeData(
      primarySwatch: Colors.green,
      scaffoldBackgroundColor: const Color(0xFFE8F5E9),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFFE8F5E9),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData.dark().copyWith(
      primaryColor: Colors.green[800],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.green[900],
      ),
      scaffoldBackgroundColor: Colors.grey[900],
    );
  }
}