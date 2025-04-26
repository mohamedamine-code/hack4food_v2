import 'package:flutter/material.dart';
import 'package:hack_for_food/pages/assosiation_home_page.dart';
import 'package:hack_for_food/pages/user_home_page.dart';


class RoutesPages extends StatefulWidget {
  final String userType; // <-- Pass userType here!

  const RoutesPages({super.key, required this.userType});

  @override
  State<RoutesPages> createState() => _RoutesPagesState();
}

class _RoutesPagesState extends State<RoutesPages> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _navigateBasedOnUserType();
  }

  Future<void> _navigateBasedOnUserType() async {
    await Future.delayed(const Duration(seconds: 2)); // optional loading time

    if (!mounted) return;

    if (widget.userType == 'association') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AssosiationHomePage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UserHomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFE8F5E9),
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        ),
      ),
    );
  }
}
