import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  String _selectedLanguage = 'Français';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader('COMPTE'),
          _buildListTile(
            icon: Icons.person,
            title: 'Modifier le profil',
            onTap: () => _navigateToEditProfile(),
          ),
          _buildListTile(
            icon: Icons.lock,
            title: 'Changer le mot de passe',
            onTap: () => _navigateToChangePassword(),
          ),

          _buildSectionHeader('PRÉFÉRENCES'),
          _buildSwitchTile(
            icon: Icons.notifications,
            title: 'Notifications',
            subtitle: 'Activer/désactiver les notifications',
            value: _notificationsEnabled,
            onChanged: (value) => _toggleNotifications(value),
          ),
          _buildSwitchTile(
            icon: Icons.dark_mode,
            title: 'Mode sombre',
            subtitle: 'Activer le mode sombre',
            value: _darkModeEnabled,
            onChanged: (value) => _toggleDarkMode(value),
          ),
          _buildListTile(
            icon: Icons.language,
            title: 'Langue',
            subtitle: _selectedLanguage,
            onTap: () => _showLanguageDialog(context),
          ),

          _buildSectionHeader('CONFIDENTIALITÉ'),
          _buildListTile(
            icon: Icons.privacy_tip,
            title: 'Politique de confidentialité',
            onTap: () => _openPrivacyPolicy(),
          ),
          _buildListTile(
            icon: Icons.help,
            title: 'Aide & Support',
            onTap: () => _navigateToHelp(),
          ),
          _buildListTile(
            icon: Icons.info,
            title: 'À propos',
            onTap: () => _navigateToAbout(),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return SwitchListTile(
      secondary: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
    );
  }

  void _toggleNotifications(bool value) {
    setState(() => _notificationsEnabled = value);
    // Sauvegarder le choix dans les préférences
  }

  void _toggleDarkMode(bool value) {
    setState(() => _darkModeEnabled = value);
    // Implémenter le changement de thème
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choisir la langue'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption('Français'),
            _buildLanguageOption('Anglais'),
            _buildLanguageOption('Arabe'),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String language) {
    return RadioListTile(
      title: Text(language),
      value: language,
      groupValue: _selectedLanguage,
      onChanged: (value) {
        setState(() => _selectedLanguage = value.toString());
        Navigator.pop(context);
        // Implémenter le changement de langue
      },
    );
  }

  // Méthodes de navigation (à implémenter)
  void _navigateToEditProfile() {}
  void _navigateToChangePassword() {}
  void _openPrivacyPolicy() {}
  void _navigateToHelp() {}
  void _navigateToAbout() {}
}