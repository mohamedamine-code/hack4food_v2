import 'package:flutter/material.dart';

import 'package:hack_for_food/pages/screens/AddDonationScreen.dart';
import 'package:hack_for_food/pages/screens/list_of_donation.dart';
import 'package:hack_for_food/pages/outils/profile_asso.dart';
import 'package:hack_for_food/pages/outils/settings.dart';
import 'package:hack_for_food/pages/routesPage/donner_Type_user.dart';
import 'package:hack_for_food/util/Widget_Button.dart';

class AssosiationHomePage extends StatefulWidget {
  const AssosiationHomePage({super.key});

  @override
  State<AssosiationHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<AssosiationHomePage> {
   void _showNotifications(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Aucune nouvelle notification'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
  final Color primaryColor = Colors.green.shade700;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void go_publier(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddDonationScreen()));
  }
  void go_tolist(){
    
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Liste()));
  }
  void go_profile_assocition(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>AssociationProfileScreen()));
  }
  void go_profile(){}
  void _openSettings() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );
  }
  void _logout(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>DonorTypePage()),
      
    );
  }

  @override
  Widget build(BuildContext context) {
    List MyList=[
    ['List des Don','assets/img/file.png',Colors.green,go_tolist],
    ['Association','assets/img/boy.png',Colors.deepPurple,go_profile_assocition],
  ];

    return Scaffold(
      drawer: Drawer(
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
    ),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu, size: 30),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        actions: [
          IconButton(
          icon: const Icon(Icons.notifications_outlined, size: 30),
          onPressed: () => _showNotifications(context),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    children: [
                      Text(
          'MealSaver! مرحبا بك في',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            children: [
              const TextSpan(text: 'Bienvenue sur '),
              TextSpan(
                text: 'MealSaver !',
                style: TextStyle(color: primaryColor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Plateforme de dons alimentaires',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          textAlign: TextAlign.center,
        ),
                    ],
                  ),
                ),
                
                SizedBox(height: 50),
                SizedBox(
                  height: 450,
                  // width: 500,
                  child: ListView.builder(
                    itemCount: MyList.length,
                    itemBuilder: (context, index) {
                      return Widget_Button(
                        funcction: () {
                          MyList[index][3]();
                          print('yy');
                        },
                        Icon_cont: MyList[index][1],
                        color_Cont: MyList[index][2],
                        data: MyList[index][0],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
