import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:bazino/utils/constants.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
class SocketController extends GetxController {
  RxInt geted=0.obs;
  RxString msg="".obs;
  RxString content="".obs;
  int canceled=0;
  late IO.Socket socket;
  final LocalStorage storage = new LocalStorage('app');
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  onInit() {
    flutterLocalNotificationsPlugin=new FlutterLocalNotificationsPlugin();
    var android=AndroidInitializationSettings("@mipmap/ic_launcher");
    var IOS=IOSInitializationSettings();
    var initSetting=InitializationSettings(android: android,iOS: IOS);
    flutterLocalNotificationsPlugin.initialize(initSetting,onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
      }
      print(payload);
    });

    int UserRef = storage.getItem('UserRef') ?? 0;
    if(UserRef==0){
      UserRef=UserRefHelper;
    }
    // socket=IO.io("http://185.190.39.86:3000",<String,dynamic>{
    socket=IO.io("http://bazino-app.ir:3000",<String,dynamic>{
      "transports":["websocket"],
      "autoConnect":true,
    });
    socket.onDisconnect((data) => (){
      print("onDisconnect");
    });
    socket.connect();
    socket.on('connect', (_){
      // basketGlob[4]="5.5";
      // socket.emit("orderdata",{'action': 'getFactor', 'key': ApiKey,'basket': json.encode(basketGlob.toString())});
      socket.emit("userref",UserRef);
      print('connect:::1: ${socket.id}');
    });
    socket.on('disconnect', (_){
      print('disconnect:::1: ${socket.id}');
    });
    socket.on('reconnect', (_){
      // socket.emit("userref","A5");
      print('reconnect:::1: ${socket.id}');
    });
    // socket.on("fromserver", (data) => print(data));
    socket.on("fromserver", (data) => print(data));
    socket.on('driverInfo', (data){
      print("GET DRIVER INFO____________");
      print('driverInfo: ${data["name"]}');
      DriverName=data["name"];
      Drivercar=data["car"];
      DriverPelak=data["pelak"];
      DriverPelakCity=data["pelakcity"];
      DriverImage=data["profilepic"];
      DriverLat=data["lati"];
      DriverLong=data["longi"];
      DriverRef=data["id"];
      DriverMobile=data["mobile"];
      // Get.delete<SocketController>();
      Get.offAllNamed("/DriverinfoScreen",arguments: [this]);
    });
    socket.on('accept_request', (data){
      print("GETED____NOTY");
        Notify("درخواست شما قبول شد", "راننده درخواست شما را قبول کرد و به زودی به محل شما می رسد");
    });

    socket.on('cancel_request_user', (data){
      // socket.dispose();
      if(canceled==0){
        print("gETED CANCELLLL");
        canceled=1;
        Get.snackbar("..", "..",
            titleText: Text("درخواست با موفقیت لغو شد", textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontFamily: 'yekan'),),
            // messageText: Text("ثبت نام شما با موفقیت انجام شد", textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontFamily: 'yekan', fontSize: 16),),
            backgroundColor: Colors.black,
            icon: Icon(Icons.check_circle, color: Colors.green, textDirection: TextDirection.rtl,),
            duration: Duration(seconds: 5),
            //     snackPosition: SnackPosition.BOTTOM,
            overlayColor: Colors.grey.withOpacity(0.5),
            dismissDirection:
            DismissDirection.horizontal,
            overlayBlur: 1,
            colorText: Colors.white);
        Get.offAllNamed("/AddressScreen");
      }
    });

    socket.on('cancel_request_driver', (data){
        Notify("سفارش لغو شد", "درخواست شما توسط راننده لغو شد");
      // socket.dispose();
        Get.defaultDialog(
          barrierDismissible: false,
          onWillPop: ()async{
            Get.offAllNamed("/AddressScreen");
            return false;
          },
          title:"درخواست شما توسط راننده لغو شد" ,
          titleStyle: TextStyle(fontFamily: 'yekan',fontSize: 16,),
          titlePadding:EdgeInsets.fromLTRB(0, 10, 0, 10),
          content: Container(
              width: Get.width,
              child:Column(
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(15, 5, 15, 10),
                      child:Text(
                        "شما می توانید سفارش خود را مجددا ثبت کنید",
                        style: TextStyle(color: Colors.black87,  fontFamily: 'yekan',fontWeight: FontWeight.bold),
                        textDirection: TextDirection.rtl,
                      )
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                      decoration: BoxDecoration(
                          color: BaseColor,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.green,)
                      ),
                      child:TextButton(
                          onPressed: () {
                            Get.offAllNamed("/AddressScreen");
                          },
                          child: Container(

                            alignment: Alignment.center,
                            child: Text(
                              "قبول",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'yekan'),
                            ),
                          ))

                  ),
                ],
              ))
      );
        // Get.offAllNamed("/AddressScreen");

    });
    socket.on('complete_request_driver', (data){
      Notify("تکمیل سفارش", "سفارش شما تکمیل شد");
      // socket.dispose();
      Get.defaultDialog(
          barrierDismissible: false,
          onWillPop: ()async{
            Get.offAllNamed("/HomeScreen");
            return false;
          },
          title:"سفارش شما تکمیل شد" ,
          titleStyle: TextStyle(fontFamily: 'yekan',fontSize: 16,),
          titlePadding:EdgeInsets.fromLTRB(0, 10, 0, 10),
          content: Container(
              width: Get.width,
              child:Column(
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(15, 5, 15, 10),
                      child:Text(
                        "با انتخاب گزینه زیر به صفحه ی اصلی منتقل خواهید شد",
                        style: TextStyle(color: Colors.black87,  fontFamily: 'yekan',fontWeight: FontWeight.bold),
                        textDirection: TextDirection.rtl,
                      )
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                      decoration: BoxDecoration(
                          color: BaseColor,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.green,)
                      ),
                      child:TextButton(
                          onPressed: () {
                            Get.offAllNamed("/HomeScreen");
                          },
                          child: Container(

                            alignment: Alignment.center,
                            child: Text(
                              "قبول",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'yekan'),
                            ),
                          ))

                  ),
                ],
              ))
      );
      // Get.offAllNamed("/AddressScreen");

    });
    print(socket.connected);

    // if(socket.connected){
    //   print("YESSSS3");
    //   socket.emit("userref","A5");
    // }
  }
  void Notify(String title,String body) async {
    var myandroid=AndroidNotificationDetails("mybazino", "bazino",priority:Priority.max,importance: Importance.max);
    var myIOS=IOSNotificationDetails();
    var platform=new NotificationDetails(android: myandroid,iOS: myIOS);
    await flutterLocalNotificationsPlugin.show(0, title, body, platform,payload: "EHSANNN");
  }
}
