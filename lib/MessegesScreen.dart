import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazino/utils/constants.dart';
import 'package:bazino/View/BottomNav.dart';
import 'package:lottie/lottie.dart';
import 'Controller/MessegesController.dart';
import 'Controller/OrdersController.dart';
import 'Model/MessegesModel.dart';
import 'Model/OrdersModel.dart';
import 'View/ApppBar.dart';
import 'View/Loading.dart';
import 'View/MsgBox.dart';
import 'View/MyDrawer.dart';

class MessegesScreen extends StatelessWidget {
  MessegesController messegesController = Get.put(MessegesController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed("/HomeScreen");
        return true;
      },
      child: Scaffold(
        endDrawer:MyDrawer(),
        // backgroundColor: Colors.white,
        body: Obx(() {
          return Container(

            child: Column(
              children: [
                ApppBar(title: "صندوق پیام ها", back: "/HomeScreen"),
                Expanded(
                  flex: 1,
                  child: messegesController.geted.value == 1
                      ? Loading():
                        messegesController.geted.value == 4?MsgBox(type:1,screen: "/MessegesScreen",)
                      : messegesController.geted.value == 3
                          ? MsgBox(title: "صندوق پیام شما خالی است",
                        content: "هیچ پیامی تاکنون برای شما ارسال نشده است",
                        img: "notfound.png",)
                          : Container(
                                    margin: EdgeInsets.fromLTRB(5, 0, 5, 25),
                                    // transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                                    child: ListView.builder(
                                      itemCount: messegesController.msges.length,
                                      itemBuilder: (context, position) {
                                        return genItem(
                                            messegesController.msges[position],
                                            position);
                                      },
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    ),
                                  )

                )
              ],
            ),
          );
        }),
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
      ),
    );
  }

  InkWell genItem(MessegesModel msgModel, int position) {
    return InkWell(
      // splashColor: Colors.white,
      onTap: () {
        OrderRef=msgModel.ID;
        Get.toNamed("/HomeScreen");
        // print(order.ID);
      },
      child: Card(
        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        elevation: 4,
        child: Container(

          child: Column(
            children: [
            Container(
              decoration: BoxDecoration(
                  color: BaseColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10))
              ),
              padding: EdgeInsets.fromLTRB(5, 0, 10, 0),

              height: 40,
            alignment: Alignment.centerRight,
            // color: Colors.cyan,
            child: Text(msgModel.Title,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "yekan",
                    fontWeight: FontWeight.bold,
                    fontSize: 15)
            ),
          ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 15, 10),

              alignment: Alignment.centerRight,

                // color: Colors.cyan,
                child: Text(msgModel.Message,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        color: Colors.black87,
                        fontFamily: "yekan",
                        fontSize: 14)
                ),
              ),
              Divider(color:Colors.black26,),
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 15, 5),

                alignment: Alignment.centerLeft,

                // color: Colors.cyan,
                child: Row(
                  children: [
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 5, 2),
                        alignment:Alignment.centerLeft,
                        child: Icon(Icons.access_time,color: Colors.black54, textDirection: TextDirection.rtl,size: 20,)
                    ),
                    Text(msgModel.Date,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: "yekan",
                            fontSize: 14)
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
