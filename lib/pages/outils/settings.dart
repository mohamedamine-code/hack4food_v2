import 'package:flutter/material.dart';
import 'package:hack_for_food/pages/outils/about.dart';
import 'package:hack_for_food/pages/outils/aide_support.dart';
import 'package:hack_for_food/pages/outils/modifier_profil.dart';
import 'package:hack_for_food/pages/outils/politique_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  String _selectedLanguage = 'Français';
  final List<String> _languages = ['Français', 'Anglais', 'Arabe'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildUserProfileHeader(),
            const SizedBox(height: 16),
            _buildSettingsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/default_profile.png'),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nom Utilisateur',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                'utilisateur@example.com',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildSectionHeader('COMPTE'),
          _buildSettingItem(
            icon: Icons.person_outline,
            title: 'Modifier le profil',
            onTap: _navigateToEditProfile,
          ),
          _buildSettingItem(
            icon: Icons.lock_outline,
            title: 'Changer le mot de passe',
            onTap: _navigateToChangePassword,
          ),
          const Divider(height: 24),

          _buildSectionHeader('PRÉFÉRENCES'),
          _buildSwitchSettingItem(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            value: _notificationsEnabled,
            onChanged: _toggleNotifications,
          ),
          _buildSwitchSettingItem(
            icon: Icons.dark_mode_outlined,
            title: 'Mode sombre',
            value: _darkModeEnabled,
            onChanged: _toggleDarkMode,
          ),
          _buildSettingItem(
            icon: Icons.language_outlined,
            title: 'Langue',
            trailing: Text(
              _selectedLanguage,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
            ),
            onTap: () => _showLanguageDialog(context),
          ),
          const Divider(height: 24),

          _buildSectionHeader('AIDE ET CONFIDENTIALITÉ'),
          _buildSettingItem(
            icon: Icons.privacy_tip_outlined,
            title: 'Politique de confidentialité',
            onTap: _openPrivacyPolicy,
          ),
          _buildSettingItem(
            icon: Icons.help_outline,
            title: 'Aide & Support',
            onTap: _navigateToHelp,
          ),
          _buildSettingItem(
            icon: Icons.info_outline,
            title: 'À propos',
            onTap: _navigateToAbout,
          ),
          const SizedBox(height: 24),
          
          _buildLogoutButton(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          title,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, size: 24),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: trailing ?? const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }

  Widget _buildSwitchSettingItem({
    required IconData icon,
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      secondary: Icon(icon, size: 24),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      value: value,
      onChanged: onChanged,
      activeColor: Theme.of(context).primaryColor,
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        icon: const Icon(Icons.logout, size: 20),
        label: const Text('Déconnexion'),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: _confirmLogout,
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choisir la langue'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _languages.length,
            itemBuilder: (context, index) {
              final language = _languages[index];
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
            },
          ),
        ),
      ),
    );
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Déconnexion'),
        content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Implémenter la déconnexion
            },
            child: const Text('Déconnexion', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _toggleNotifications(bool value) {
    setState(() => _notificationsEnabled = value);
    // Sauvegarder le choix dans les préférences
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          value ? 'Notifications activées' : 'Notifications désactivées'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _toggleDarkMode(bool value) {
    setState(() => _darkModeEnabled = value);
    // Implémenter le changement de thème
  }

  // Méthodes de navigation
  void _navigateToEditProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ModifierProfilScreen()),
    );
  }

  void _navigateToChangePassword() {
    // Implémenter la navigation
  }

  void _openPrivacyPolicy() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen()),
    );
  }

  void _navigateToAbout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AboutFoodWasteWidget()),
    );
  }

  void _navigateToHelp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AideSupportScreen()),
    );
  }
}