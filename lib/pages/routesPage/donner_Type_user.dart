import 'package:flutter/material.dart';

import 'package:hack_for_food/pages/SignIn_SignUp/login.dart';

class DonorTypePage extends StatelessWidget {
  const DonorTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE8F5E9) ,
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Choisir votre profil',
          style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold, color: Colors.black),
        ),
        automaticallyImplyLeading: false, 
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: const Text(
                  'Bienvenue ! ',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              
              _buildDonorTypeCard(
                context,
                title: 'Donneur',
                path: 'assets/img/man.png',
                onTap: () => _navigateToLogin(context, isAssociation: false),
              ),
              const SizedBox(height: 30),
              _buildDonorTypeCard(
                context,
                title: 'Association',
                path: 'assets/img/community.png',
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
    required String path,
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
            Image.asset(path, width: 90,),
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
