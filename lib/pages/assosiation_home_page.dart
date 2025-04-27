import 'package:flutter/material.dart';

import 'package:hack_for_food/pages/AddDonationScreen.dart';
import 'package:hack_for_food/pages/list_of_donation.dart';
import 'package:hack_for_food/pages/profile_asso.dart';
import 'package:hack_for_food/pages/settings.dart';
import 'package:hack_for_food/test_widget/donner_Type_user.dart';
import 'package:hack_for_food/util/Widget_Button.dart';

class AssosiationHomePage extends StatefulWidget {
  const AssosiationHomePage({super.key});

  @override
  State<AssosiationHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<AssosiationHomePage> {


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
  void _logout() async {
    // Implémentation de la déconnexion
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const DonorTypePage()),
      (route) => false,
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
        leading: IconButton(onPressed: (){
          
        }, icon: Icon(Icons.menu,size: 30,)),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.notification_add,color: Colors.black,size: 30,))
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
                      Container( 
                    child: Text(
                      'ZADNA! مرحبا بك في ',
                      style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Bienvenue sur ',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'ZADEN !',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    
                  ),
                    ],
                  ),
                ),
                
                SizedBox(height: 50),
                SizedBox(
                  height: 450,
                  // width: 500,
                  child: GridView.builder(
                    itemCount: MyList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.7/2.5,
                    ),
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
