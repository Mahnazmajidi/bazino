import 'dart:io';
import 'package:bazino/Controller/SearchController.dart';
import 'package:bazino/Controller/SocketController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazino/utils/constants.dart';
import 'package:bazino/View/BottomNav.dart';
import 'package:localstorage/localstorage.dart';
import 'package:lottie/lottie.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'View/ApppBar.dart';
import 'View/Loading.dart';
import 'View/MsgBox.dart';
import 'View/MyDrawer.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
final LocalStorage storage = new LocalStorage('app');
class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  bool canCancel=false;
   SearchController searchController = Get.put(SearchController());
   SocketController socketController = Get.put(SocketController());

   int UserRef = storage.getItem('UserRef') ?? 0;
   Future<int> res = searchController.newOrder();
   res.then(
         (int value) {
       if (value > 0) {
         canCancel=true;
         socketController.socket.emit('newrorder',{'orderref': value.toString(),'userref': UserRef.toString(), 'key': ApiKeySocket});
         socketController.dispose();
       } else {
         Get.snackbar("..", "..",
             titleText: Text("خطا", textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontFamily: 'yekan'),),
             messageText: Text(searchController.msg.value, textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontFamily: 'yekan', fontSize: 16),),
             backgroundColor: Colors.black,
             icon: Icon(Icons.error, color: Colors.red, textDirection: TextDirection.rtl,),
             duration: Duration(seconds: 3),
             //     snackPosition: SnackPosition.BOTTOM,
             overlayColor: Colors.grey.withOpacity(0.5),
             dismissDirection:DismissDirection.horizontal,
             overlayBlur: 1,
             colorText: Colors.white);
         Get.offAllNamed("/AddressScreen");
       }
     },
   );
   return WillPopScope(
      onWillPop: () async {
        Get.snackbar("..", "..",
            titleText: Text("در حال یافتن راننده", textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontFamily: 'yekan'),),
            messageText: Text("ابتدا درخواست خود را لغو کنید", textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontFamily: 'yekan', fontSize: 16),),
            backgroundColor: Colors.black,
            icon: Icon(Icons.error, color: Colors.red, textDirection: TextDirection.rtl,),
            duration: Duration(seconds: 2),
            //     snackPosition: SnackPosition.BOTTOM,
            overlayColor: Colors.grey.withOpacity(0.5),
            dismissDirection:DismissDirection.horizontal,
            overlayBlur: 1,
            colorText: Colors.white);
        return false;
      },
      child: Scaffold(
        endDrawer:MyDrawer(),
        // backgroundColor: Colors.white,
        body:  Container(
            decoration: new BoxDecoration(
              color: BackgroundColor,
              // borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Column(
              children: [
                ApppBar(title: "جستجوی راننده",hasback: true,hasmenu: false,),
                Expanded(
                  flex:4,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text("تا پیدا شدن راننده منتظر بمانید",style: TextStyle(fontFamily: 'yekan',fontSize: 18),textDirection: TextDirection.rtl,),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child:   Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: AdsPic==""?Lottie.asset(
                      'assets/search.json',
                      height: 150,
                    ):
                    Container(child: Image(
                      image: NetworkImage(Url+"/images/ads/"+AdsPic),
                      height: 200,
                    ),)
                    ,
                  ),
                ),
                Expanded(
                  flex:6,
                  child: Container(),
                ),

                Expanded(
                  flex: 4,
                  child:   Obx((){
                    return Container(
                      child:  Column(

                        children: [
                          Container(
                            decoration: new BoxDecoration(
                              color: BaseColor,
                              borderRadius: BorderRadius.all( Radius.circular(15)),
                            ),
                            width: Get.width,
                            height: 60,
                            margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child:   TextButton(

                                onPressed: () {
                                  if(canCancel){
                                    Future<int> res = searchController.cancel_request_user();
                                    res.then(
                                          (int value) {
                                        if (value > 0) {
                                          socketController.socket.emit('cancel_request_user',{'orderref': OrderRef.toString(),'userref': UserRef.toString(),'level': "0", 'key': ApiKeySocket});
                                          // socketController.dispose();
                                          Get.snackbar("..", "..",
                                              titleText: Text("لغو شد", textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontFamily: 'yekan'),),
                                              messageText: Text("سفارش با موفقیت لغو شد", textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontFamily: 'yekan', fontSize: 16),),
                                              backgroundColor: Colors.black,
                                              icon: Icon(Icons.check_circle, color: Colors.green, textDirection: TextDirection.rtl,),
                                              duration: Duration(seconds: 4),
                                              //     snackPosition: SnackPosition.BOTTOM,
                                              overlayColor: Colors.grey.withOpacity(0.5),
                                              dismissDirection:
                                              DismissDirection.horizontal,
                                              overlayBlur: 1,
                                              colorText: Colors.white);
                                          Get.offAllNamed("/AddressScreen");
                                        } else {

                                          Get.snackbar("..", "..",
                                              titleText: Text("خطا", textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontFamily: 'yekan'),),
                                              messageText: Text(searchController.msg.value, textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontFamily: 'yekan', fontSize: 16),),
                                              backgroundColor: Colors.black,
                                              icon: Icon(Icons.error, color: Colors.red, textDirection: TextDirection.rtl,),
                                              duration: Duration(seconds: 3),
                                              //     snackPosition: SnackPosition.BOTTOM,
                                              overlayColor: Colors.grey.withOpacity(0.5),
                                              dismissDirection:DismissDirection.horizontal,
                                              overlayBlur: 1,
                                              colorText: Colors.white);
                                          Get.offAllNamed("/AddressScreen");
                                        }
                                      },
                                    );
                                  }
                                  else{
                                    Get.snackbar("..", "..",
                                        titleText: Text("خطا در لغو درخواست", textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontFamily: 'yekan'),),
                                        messageText: Text("مجددا تلاش کنید", textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontFamily: 'yekan', fontSize: 16),),
                                        backgroundColor: Colors.black,
                                        icon: Icon(Icons.error, color: Colors.red, textDirection: TextDirection.rtl,),
                                        duration: Duration(seconds: 3),
                                        //     snackPosition: SnackPosition.BOTTOM,
                                        overlayColor: Colors.grey.withOpacity(0.5),
                                        dismissDirection:DismissDirection.horizontal,
                                        overlayBlur: 1,
                                        colorText: Colors.white);
                                  }
                                },
                                child: Container(
                                  color: BaseColor,


                                  height: 60,
                                  width: Get.width,
                                  alignment: Alignment.center,
                                  child:
                                  searchController.getedCancel.value!=0?
                                  CircularProgressIndicator(color: Colors.white,)
                                      :Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "لغو درخواست",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'yekan'),
                                      ),
                                      Container(
                                          margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                          child: Icon(Icons.clear,color: Colors.white,size: 25,)),
                                    ],
                                  ),
                                )),
                          )

                        ],
                      ),
                    );
                  }),
                ),
                Expanded(
                  flex: 1,
                  child:   Container(
                  ),
                ),

              ],
            ),
          ) ,
        //
        // bottomNavigationBar: BottomNav(),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: (){
        //     Get.offAllNamed("/CategoryScreen");
        //   },
        //   child: Icon(
        //     Icons.home,
        //     color: Colors.white,
        //   ),
        //   backgroundColor: BaseColor,
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

}
