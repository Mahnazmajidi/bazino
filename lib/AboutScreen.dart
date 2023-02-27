import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazino/utils/constants.dart';
import 'package:bazino/View/BottomNav.dart';
import 'package:localstorage/localstorage.dart';
import 'Controller/AboutController.dart';
import 'View/ApppBar.dart';
import 'View/Loading.dart';
import 'View/MsgBox.dart';
import 'View/MyDrawer.dart';
final LocalStorage storage = new LocalStorage('app');
class AboutScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    AboutController aboutController = Get.put(AboutController());
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed("/CategoryScreen");
        return false;
      },
      child: Obx((){
        return  Scaffold(
          endDrawer:MyDrawer(),
          // backgroundColor: Colors.white,
          body: Container(
            decoration: new BoxDecoration(
              color: Colors.white,
              // borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Column(
              children: [
                ApppBar(title: "درباره ما", back: "/HomeScreen"),
                aboutController.geted.value==1?Loading():
                aboutController.geted.value==3?MsgBox(title: "خطا",content:aboutController.msg.value ,):
                aboutController.geted.value==4?MsgBox(type: 4,):
                Expanded(
                  flex: 1,
                  child:   Container(
                    margin: EdgeInsets.fromLTRB(5, 0, 5, 25),
                    // transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                    child: Card(
                      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(20.0))),
                      elevation: 4,
                      child: ListView(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
                            child: Image(
                              image: AssetImage('assets/images/contact.png'),
                              height: 180,
                              // fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            margin:EdgeInsets.fromLTRB(0,0,0,50),
                            padding:EdgeInsets.fromLTRB(12,0,12,0),
                            child:Text(aboutController.content.value,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'yekan',
                                )),
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: InkWell(
                              onTap: () {
                                Get.offAllNamed("/HomeScreen");
                              },
                              child: Container(
                                // color:BaseColor,
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 45),
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: BaseColor,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                                child:Text("بازگشت", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'yekan'),),
                              ),
                            ),
                          ),


                        ],
                      ),
                    ),
                  )
                )
              ],
            ),
          ) ,

          bottomNavigationBar: BottomNav(),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              Get.offAllNamed("/HomeScreen");
            },
            child: Icon(
              Icons.home,
              color: Colors.white,
            ),
            backgroundColor: BaseColor,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        );
      })
     ,
    );
  }

}
