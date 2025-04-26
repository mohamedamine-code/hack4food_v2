import 'package:flutter/material.dart';
import 'package:hack_for_food/test_widget/donner_Type_user.dart';

class PolicyAcceptanceScreen extends StatelessWidget {
  const PolicyAcceptanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Avant de continuer',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              const Text('Vous devez accepter notre politique de confidentialité'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Sauvegarder l'acceptation (SharedPreferences)
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const DonorTypePage()),
                  );
                },
                child: const Text('Voir la politique'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}