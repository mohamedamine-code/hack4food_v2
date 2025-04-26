import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Politique de Confidentialité'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPolicySection(
              title: '1. Collecte des Informations',
              content: 'Nous collectons les informations que vous fournissez lorsque vous créez un compte ou publiez une annonce.',
            ),
            _buildPolicySection(
              title: '2. Utilisation des Données',
              content: 'Vos données sont utilisées pour :\n- Faciliter les dons alimentaires\n- Améliorer notre service\n- Vous contacter si nécessaire',
            ),
            _buildPolicySection(
              title: '3. Partage des Données',
              content: 'Nous ne partageons vos données personnelles avec aucun tiers sans votre consentement explicite.',
            ),
            const SizedBox(height: 30),
            _buildAcceptanceButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicySection({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildAcceptanceButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          backgroundColor: Colors.green,
        ),
        onPressed: () {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Vous avez accepté notre politique de confidentialité'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: const Text(
          "J'accepte la politique",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}