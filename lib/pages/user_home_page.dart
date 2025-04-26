import 'package:flutter/material.dart';
import 'package:hack_for_food/pages/AddDonationScreen.dart';
import 'package:hack_for_food/pages/profile.dart';
import 'package:hack_for_food/pages/settings.dart';
import 'package:hack_for_food/test_widget/donner_Type_user.dart';
import 'package:hack_for_food/util/Widget_Button.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<UserHomePage> {
  // Méthodes de navigation
  void _navigateToAddDonation() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddDonationScreen()),
    );
  }

  void _navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DonorProfileScreen()),
    );
  }

  void _logout() async {
    // Implémentation de la déconnexion
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const DonorTypePage()),
      (route) => false,
    );
  }

  void _openSettings() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {
        'title': 'Publier un Don',
        'icon': 'assets/img/file.png',
        'color': Colors.green,
        'action': _navigateToAddDonation,
      },
      {
        'title': 'Profile',
        'icon': 'assets/img/boy.png',
        'color': Colors.deepPurple,
        'action': _navigateToProfile,
      },
    ];

    return Scaffold(
      drawer: _buildDrawer(),
      appBar: _buildAppBar(),
      body: _buildBody(menuItems),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFFE8F5E9),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.green.shade700),
            child: const Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Tableau de bord'),
            onTap: () {
              Navigator.pop(context);
              // Navigation vers le dashboard si nécessaire
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Paramètres'),
            onTap: _openSettings,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Déconnexion', style: TextStyle(color: Colors.red)),
            onTap: _logout,
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) => IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: const Icon(Icons.menu, color: Colors.black, size: 30),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications, color: Colors.black, size: 30),
        ),
      ],
    );
  }

  Widget _buildBody(List<Map<String, dynamic>> menuItems) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildWelcomeSection(),
              const SizedBox(height: 50),
              _buildMenuGrid(menuItems),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      children: [
        const Text(
          'ZADNA! مرحبا بك في ',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: 'Bienvenue sur ',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: 'ZADEN !',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuGrid(List<Map<String, dynamic>> items) {
    return SizedBox(
      height: 450,
      child: GridView.builder(
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.7 / 2.5,
        ),
        itemBuilder: (context, index) {
          return Widget_Button(
            funcction: items[index]['action'],
            Icon_cont: items[index]['icon'],
            color_Cont: items[index]['color'],
            data: items[index]['title'],
          );
        },
      ),
    );
  }
}