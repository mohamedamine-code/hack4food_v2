import 'package:flutter/material.dart';

class Widget_Button extends StatelessWidget {
  const Widget_Button({super.key, this.color_Cont,required this.Icon_cont,required this.data,required this.funcction});
  final color_Cont;
  final String Icon_cont;
  final String data;
  final VoidCallback funcction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          funcction();
        },
        child: Container(
          padding: EdgeInsets.all(15),
          height: 400,
          width: 150,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                spreadRadius: 1.5,
                blurRadius: 5,
              )
            ],
            borderRadius: BorderRadius.circular(15),
            color: color_Cont,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 12,
              ),
              Image.asset(Icon_cont,width: 70,),
              SizedBox(
                height: 50,
              ),
              Text(data,textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),)
            ],
          ),
        ),
      ),
    );
  }
}