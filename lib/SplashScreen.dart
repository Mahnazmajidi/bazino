import 'package:flutter/material.dart';
import 'package:bazino/utils/constants.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';

class SplashScreen extends StatelessWidget {
  final LocalStorage storage = new LocalStorage('app');
  String appver="";
  int i=0;
  @override
  Widget build(BuildContext context) {
    appver="";
    i=0;
    AppVersion.runes.forEach((int rune) {
      if(i>0){
        appver+=".";
      }
      appver+=String.fromCharCode(rune);
      i++;
    });
    Future.delayed(const Duration(milliseconds: 2000), () {
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => HomeScreen()));
      int UserRef = storage.getItem('UserRef') ?? 0;
      if(UserRef>0){
        UserRefHelper=UserRef;
      }
      Get.offAllNamed("/HomeScreen");

    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(

          child:Column(
            children: [
              Expanded(flex:2,
                child: Container(),
              ),
              Expanded(flex:7,
                child: Container(
                  margin: EdgeInsets.fromLTRB(50, 50, 50, 50),
                  child: Image(image: AssetImage('assets/images/logo.png'),),),
              ),
              Expanded(flex:1,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text("بازینو",textDirection: TextDirection.rtl,style: TextStyle(fontFamily: 'yekan',fontSize: 28,fontWeight: FontWeight.bold),),),
              ),
              Expanded(flex:2,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  alignment: Alignment.topCenter,
                  child: Text(" قلب دوم طبیعت",textDirection: TextDirection.rtl,style: TextStyle(fontFamily: 'yekan',fontSize: 18,fontWeight: FontWeight.bold),),),
              ),
              Expanded(flex:2,
                child: Container(),
              ),

              Expanded(flex:2,
                child: Container(
                  alignment: Alignment.center,
                  child: Text("ورژن "+appver,textDirection: TextDirection.rtl,style: TextStyle(fontFamily: 'yekan',fontSize: 14),),),
              ),
            ],
          )

      ),
    );
  }
}
