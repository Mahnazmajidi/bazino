import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazino/utils/constants.dart';
import 'package:bazino/View/BottomNav.dart';
import 'package:localstorage/localstorage.dart';

import 'Controller/HomeController.dart';
import 'View/ApppBar.dart';
import 'View/MyDrawer.dart';
final LocalStorage storage = new LocalStorage('app');
class HomeScreen extends StatelessWidget {
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    int UserRef = storage.getItem('UserRef') ?? 0;
    if(UserRef==0){
      UserRef=UserRefHelper;
    }
   return
      Scaffold(
        endDrawer:MyDrawer(),
        // backgroundColor: Colors.white,
        body:  DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text("جهت خروج از برنامه یک مرتبه دیگر گزینه بازگشت را انتخاب کنید",
                style: TextStyle(color: Colors.white, fontFamily: "yekan")),
          ),
          child: Container(
              decoration: new BoxDecoration(
                color: BackgroundColor,
                // borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Obx((){
                    return ApppBar(title: "بازینو", IsHome: 1,unread: homeController.unreadMsg.value,);
                  }),
                  Expanded(
                    flex: 4,
                    child:   Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child:  Image(
                        image: AssetImage('assets/images/logo.png'),
                        width: 200,
                        // fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child:   Container(
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child:   Container(
                      child:  Column(

                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                              decoration: new BoxDecoration(
                                color: BaseColor,
                                borderRadius: BorderRadius.all( Radius.circular(10)),
                              ),
                              child:TextButton(
                              onPressed: () {
                                if(UserRef==0){
                                  Get.offAllNamed("/ProfileScreen",arguments: ["جهت ثبت درخواست ابتدا وارد حساب کاربری خود شوید"]);
                                }
                                else{
                                  RecycleType=1;
                                  Get.offAllNamed("/CategoryScreen");
                                }
                              },
                              child: Container(
                                height: 40,
                                width: 300,
                                alignment: Alignment.center,
                                child: Text(
                                  "بازیافت خانگی",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'yekan'),
                                ),
                              ))),
                          Container(
                              margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
                              decoration: new BoxDecoration(
                                color: BaseColor,
                                borderRadius: BorderRadius.all( Radius.circular(10)),
                              ),
                              child:TextButton(
                                  onPressed: () {
                                    if(UserRef==0){
                                      Get.offAllNamed("/ProfileScreen",arguments: ["جهت ثبت درخواست ابتدا وارد حساب کاربری خود شوید"]);
                                    }
                                    else{
                                      RecycleType=2;
                                      Get.offAllNamed("/CategoryScreen");
                                    }
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 300,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "بازیافت ساختمانی",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'yekan'),
                                    ),
                                  ))),
                        ],
                      ),
                    ),
                  ),


                ],
              ),
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
  }

}
