import 'package:flutter/material.dart';

import 'package:hack_for_food/pages/AddDonationScreen.dart';
import 'package:hack_for_food/util/Widget_Button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  void go_publier(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddDonationScreen()));
  }
  void go_difuser (){
    
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>()));
  }
  void go_association(){}
  void go_profile(){}


  @override
  Widget build(BuildContext context) {
    List MyList=[
    ['Publier un Don','assets/img/file.png',Colors.green,go_publier],
    ['Profile','assets/img/boy.png',Colors.deepPurple,go_profile],
  ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu,size: 30,)),
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
                      childAspectRatio: 1.7/2,
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
