import 'package:flutter/material.dart';
import 'package:hack_for_food/pages/AddDonationScreen.dart';
import 'package:hack_for_food/pages/profile.dart';
import 'package:hack_for_food/util/Widget_Button.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<UserHomePage> {
  void go_publier() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddDonationScreen()),
    );
  }

  void go_difuser() {
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>()));
  }
  void go_association() {}
  void go_profile() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>DonorProfileScreen()));
  }

  @override
  Widget build(BuildContext context) {
    List MyList = [
      ['Publier un Don', 'assets/img/file.png', Colors.green, go_publier],
      ['Profile', 'assets/img/boy.png', Colors.deepPurple, go_profile],
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
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // You can navigate here
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Settings
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                // Handle logout
              },
            ),
          ],
        ),
      ),

      appBar: AppBar(
        leading: Builder(
          builder:
              (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.menu,color: Colors.black,size: 30,),
              ),
        ),
      
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notification_add, color: Colors.black, size: 30),
          ),
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
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
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
                      childAspectRatio: 1.7 / 2.5,
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
