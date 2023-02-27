import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazino/utils/constants.dart';
class ApppBar extends StatelessWidget {
  String title = AppName;
  String back = "";
  int IsHome=0;
  int unread=0;
  double marginTop=20;
  bool hasback=true;
  bool hasmenu=true;
  ApppBar({this.title = AppName,this.back = "",this.IsHome=0,this.hasback=true,this.hasmenu=true,this.unread=0,});

  @override
  Widget build(BuildContext context) {
    if(IsHome==1){
      this.marginTop=15;
    }

    return Container(
        padding: EdgeInsets.fromLTRB(0, this.marginTop, 0, 0),
        height: 80,
        alignment: Alignment.center,
        width: double.infinity,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(1)),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: IsHome==0 && this.hasback?InkWell(
                onTap: (){
                  print(back);
                  if(back=="finish"){
                    Future.delayed(const Duration(milliseconds: 2000), () {
                      print("THIS");
                      // exit(0);
                      // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                    });
                    exit(0);
                  }
                 else if(back==""){
                    Get.back();

                  }
                  else{
                    Get.offAllNamed(back);
                  }
                },
                  child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black87,
                size: 18,
              )):
              InkWell(
                  onTap: (){
                    Get.offAllNamed("/MessegesScreen");

                  },
                  child: this.unread==0?Icon(Icons.notifications_none,
                    color: Colors.black87,
                    size: 25,
                  ):
                  Icon(Icons.notifications_active,
                    color: Colors.red,
                    size: 25,
                  )

              )
              ,
            ),
            Expanded(
              flex: 6,
              child: IsHome==0?Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color:Colors.black87,
                      fontSize: 22,
                      fontFamily: 'yekan',
                      fontWeight: FontWeight.w700)):
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text("بازینو",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color:Colors.black,
                        fontSize: 22,
                        fontFamily: 'yekan',
                        fontWeight: FontWeight.w700)),
              )
              ,
            ),
            Expanded(
              flex: 2,
              child: this.hasmenu?Container(
                margin: EdgeInsets.fromLTRB(0, 5, 30, 0),
                  alignment: Alignment.centerRight,
                  child:InkWell(
                      onTap: (){
                        Scaffold.of(context).openEndDrawer();
                      },
                      child: Icon(Icons.menu,color: Colors.black87,size: 26,)))
              :Container(),
            ),
          ],
        ));
  }
}
