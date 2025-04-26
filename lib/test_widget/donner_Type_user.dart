import 'package:flutter/material.dart';
import 'package:hack_for_food/pages/loginpage.dart';
import 'package:hack_for_food/test_widget/login.dart';

class DonorTypePage extends StatelessWidget {
  const DonorTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9), // Light green background
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50), // Green app bar
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Choisir votre profil',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        automaticallyImplyLeading: false, // Remove back arrow
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Vous êtes :',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
              const SizedBox(height: 40),
              _buildDonorTypeCard(
                context,
                title: 'Donneur Individuel',
                icon: Icons.person_outline,
                onTap: () => _navigateToLogin(context, isAssociation: false),
              ),
              const SizedBox(height: 30),
              _buildDonorTypeCard(
                context,
                title: 'Association',
                icon: Icons.groups,
                onTap: () => _navigateToLogin(context, isAssociation: true),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDonorTypeCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap, // <-- CLIC !
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        height: 200,
        width: 300,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(color: Colors.black26, spreadRadius: 1.5, blurRadius: 5),
          ],
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xFFE8F5E9),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            Icon(icon, size: 70, color: const Color(0xFF2E7D32)),
            const SizedBox(height: 30),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToLogin(BuildContext context, {required bool isAssociation}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => LoginScreen_01(
              userType: isAssociation ? 'association' : 'donor',
            ),
      ),
    );
  }
}
