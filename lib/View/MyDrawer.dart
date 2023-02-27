import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazino/utils/constants.dart';
class MyDrawer extends StatelessWidget {

  @override
  Widget build (BuildContext ctxt) {
    return ClipRRect(
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(200.0),topLeft: Radius.circular(10.0)),
      child: new Drawer(
        backgroundColor: Colors.white,
          child: new ListView(
            children: <Widget>[
              new DrawerHeader(
                child: Column(
                  children:[
                    Center(
                        child:Image(
                          image: AssetImage(
                              'assets/images/logo.png'),
                          height: 100,
                        )
                    ),
                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Text("بازینو",style: TextStyle(color: Colors.black87,fontFamily: 'yekan',fontSize: 15),))
                ]

                ),

              ),

              ListTile(
                title:  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: Text("سفارشات قبلی",style: TextStyle(color: Colors.black87,fontFamily: 'yekan',fontSize: 15),)),
                      Icon(Icons.fact_check_outlined,color: Colors.black87,)
                    ],
                  ),
                onTap: () {
                  Get.offAllNamed("/OrdersScreen");
                },
              ),

             ListTile(
                title:  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: Text("حساب کاربری",style: TextStyle(color: Colors.black87,fontFamily: 'yekan',fontSize: 15),)),
                      Icon(Icons.account_box,color: Colors.black87,)
                    ],
                  ),
                onTap: () {
                  Get.offAllNamed("/ProfileScreen");
                },
              ),
              ListTile(
                title:  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: Text("آدرس های مننخب",style: TextStyle(color: Colors.black87,fontFamily: 'yekan',fontSize: 15),)),
                      Icon(Icons.star,color: Colors.black87,)
                    ],
                  ),
                onTap: () {
                  Get.offAllNamed("/UserAddressScreen");
                },
              ),
              ListTile(
                title:  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: Text("پیام ها",style: TextStyle(color: Colors.black87,fontFamily: 'yekan',fontSize: 15),)),
                      Icon(Icons.email_outlined,color: Colors.black87,)
                    ],
                  ),
                onTap: () {
                  Get.offAllNamed("/MessegesScreen");
                },
              ),
              ListTile(
                title:  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: Text("درباره ما",style: TextStyle(color: Colors.black87,fontFamily: 'yekan',fontSize: 15),)),
                      Icon(Icons.chat,color: Colors.black87,)
                    ],
                  ),
                onTap: () {
                  Get.offAllNamed("/AboutScreen");
                },
              ),
              ListTile(
                title:  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: Text("قوانین",style: TextStyle(color: Colors.black87,fontFamily: 'yekan',fontSize: 15),)),
                      Icon(Icons.warning_outlined,color: Colors.black87,)
                    ],
                  ),
                onTap: () {
                  Get.offAllNamed("/RulesScreen");
                },
              ),

              ListTile(
                title:  Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: Text("خروج",style: TextStyle(color: Colors.black87,fontFamily: 'yekan',fontSize: 15),)),
                    Icon(Icons.exit_to_app,color: Colors.black87,)
                  ],
                ),
                onTap: () {
                    exit(0);
                },
              ),
            ],
          )
      ),
    );
  }
}