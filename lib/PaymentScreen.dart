import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazino/utils/constants.dart';
import 'package:bazino/View/BottomNav.dart';
import 'package:localstorage/localstorage.dart';

import 'Controller/FactorController.dart';
import 'Controller/PaymentController.dart';
import 'View/ApppBar.dart';
import 'View/Loading.dart';
import 'View/MsgBox.dart';
import 'View/MyDrawer.dart';
final LocalStorage storage = new LocalStorage('app');
class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var arg = Get.arguments;
    PaymentController paymentController = Get.put(PaymentController(arg[0],arg[1]));
    // paymentController.newFactor(arg[0],arg[1]);
    // basketGlob.clear();
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed("/CategoryScreen");
        return true;
      },
      child: Scaffold(
        endDrawer:MyDrawer(),
        // backgroundColor: Colors.white,
        body: Obx((){
          return Container(
            decoration: new BoxDecoration(
              color: BaseColor,
              // borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Column(
              children: [
                ApppBar(title: "ثبت سفارش", back: "/BasketScreen"),
                Expanded(
                  flex: 1,
                  child:   Stack(
                    // overflow: Overflow.clip,
                      fit: StackFit.expand,
                      children: [
                        Container(
                          height: 200,
                          margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
                          child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            // margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                            color: GrayColor2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(40.0))),
                            elevation: 6,
                            child: Container(
                              height: 100,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 0, 15, 25),
                          // transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                          child: Card(
                            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20.0))),
                            elevation: 4,
                            child: paymentController.getedNew==1?Loading():
                            paymentController.getedNew==3?MsgBox(title:"خطا در دریافت اطلاعات",content: "لطفا مجددا تلاش کنید",screen: "/PaymentScreen",):Column(
                              children: [
                                Container(
                                  margin:EdgeInsets.fromLTRB(0,30,0,0),
                                  child: Image(
                                    image: AssetImage('assets/images/okorder.png'),
                                    width: 200,
                                    // fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                  margin:EdgeInsets.fromLTRB(0,30,0,0),
                                  child:Text("سفارش شما با موفقیت ثبت شد",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'yekan',
                                          fontWeight: FontWeight.w700)),
                                ),Container(
                                  margin:EdgeInsets.fromLTRB(0,30,0,0),
                                  child:Text("شماره سفارش: "+paymentController.orderref.value.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'yekan',
                                      )),
                                ),
                                Expanded(
                                  flex:1,
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Row(

                                      children: [
                                        Expanded(
                                          flex:1,
                                          child: InkWell(
                                            onTap: () {
                                              Get.offAllNamed("/CategoryScreen");
                                            },
                                            child: InkWell(
                                              onTap: (){
                                                Get.offAllNamed("/OrdersScreen");
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
                                                child:Text("لیست سفارشات", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'yekan'),),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex:1,
                                          child: InkWell(
                                            onTap: () {
                                              Get.offAllNamed("/CategoryScreen");
                                            },
                                            child: Container(
                                              // color:BaseColor,
                                              margin: EdgeInsets.fromLTRB(10, 0, 10, 45),
                                              height: 50,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: ThirdColor,
                                                  borderRadius:
                                                  BorderRadius.all(Radius.circular(10))),
                                              child:Text("بازگشت به صفحه اصلی", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'yekan'),),
                                            ),
                                          ),
                                        )
                                      ],

                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        )
                      ]),
                )
              ],
            ),
          );
        }) ,

        bottomNavigationBar: BottomNav(),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Get.offAllNamed("/HomeScreen");
          },
          child: Icon(
            Icons.home,
            color: SecColor,
          ),
          backgroundColor: BaseColor,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

}
