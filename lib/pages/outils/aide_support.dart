import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AideSupportScreen extends StatelessWidget {
  const AideSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aide & Support'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderSection(),
            const SizedBox(height: 30),
            _buildContactSection(context),
            const SizedBox(height: 30),
            _buildFaqSection(),
            const SizedBox(height: 30),
            _buildResourcesSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nous sommes là pour vous aider',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          'Parcourez notre centre d\'aide ou contactez notre équipe support',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Contactez-nous',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            _buildContactOption(
              icon: Icons.email,
              title: 'Email support',
              subtitle: 'Réponse sous 24h',
              onTap: () => _launchEmail(context),
            ),
            const Divider(),
            _buildContactOption(
              icon: Icons.phone,
              title: 'Support téléphonique',
              subtitle: 'Lun-Ven, 9h-18h',
              onTap: () => _launchPhoneCall(context),
            ),
            const Divider(),
            _buildContactOption(
              icon: Icons.chat,
              title: 'Chat en direct',
              subtitle: 'Disponible maintenant',
              onTap: () => _startLiveChat(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildFaqSection() {
    final faqItems = [
      {
        'question': 'Comment publier une annonce de don ?',
        'answer': 'Allez dans l\'onglet "Publier un don" et remplissez le formulaire...',
      },
      {
        'question': 'Comment modifier mon profil ?',
        'answer': 'Accédez à votre profil et cliquez sur l\'icône d\'édition...',
      },
      {
        'question': 'Problème de connexion',
        'answer': 'Vérifiez vos identifiants ou réinitialisez votre mot de passe...',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'FAQ - Questions fréquentes',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...faqItems.map((item) => _buildFaqItem(
              question: item['question']!,
              answer: item['answer']!,
            )),
      ],
    );
  }

  Widget _buildFaqItem({required String question, required String answer}) {
    return ExpansionTile(
      title: Text(question, style: const TextStyle(fontWeight: FontWeight.w500)),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(answer),
        ),
      ],
    );
  }

  Widget _buildResourcesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ressources utiles',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _buildResourceChip(
              label: 'Guide d\'utilisation',
              onTap: () => _openGuide(context),
            ),
            _buildResourceChip(
              label: 'Conditions d\'utilisation',
              onTap: () => _openTerms(context),
            ),
            _buildResourceChip(
              label: 'Politique de confidentialité',
              onTap: () => _openPrivacyPolicy(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildResourceChip({
    required String label,
    required VoidCallback onTap,
  }) {
    return ActionChip(
      label: Text(label),
      avatar: const Icon(Icons.description, size: 18),
      onPressed: onTap,
      backgroundColor: Colors.green.shade50,
      labelStyle: const TextStyle(color: Colors.green),
    );
  }

  // Méthodes d'actions
  Future<void> _launchEmail(BuildContext context) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@zadna.org',
      queryParameters: {'subject': 'Demande de support ZADNA'},
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      _showSnackBar(context, 'Impossible d\'ouvrir l\'application email');
    }
  }

  Future<void> _launchPhoneCall(BuildContext context) async {
    const phoneNumber = 'tel:+123456789';
    if (await canLaunchUrl(Uri.parse(phoneNumber))) {
      await launchUrl(Uri.parse(phoneNumber));
    } else {
      _showSnackBar(context, 'Impossible d\'ouvrir l\'application téléphone');
    }
  }

  void _startLiveChat(BuildContext context) {
    // Implémentation du chat en direct
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Chat en direct')),
          body: const Center(child: Text('Fonctionnalité de chat à venir')),
        ),
      ),
    );
  }

  void _openGuide(BuildContext context) {
    // Navigation vers le guide
    _showSnackBar(context, 'Ouverture du guide d\'utilisation');
  }

  void _openTerms(BuildContext context) {
    // Navigation vers les conditions
    _showSnackBar(context, 'Ouverture des conditions d\'utilisation');
  }

  void _openPrivacyPolicy(BuildContext context) {
    // Navigation vers la politique de confidentialité
    _showSnackBar(context, 'Ouverture de la politique de confidentialité');
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}