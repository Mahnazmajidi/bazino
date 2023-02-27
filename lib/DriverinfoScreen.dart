import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:latlong2/latlong.dart';
import 'package:localstorage/localstorage.dart';
import 'package:location/location.dart';
import 'package:get/get.dart';
import 'package:bazino/utils/constants.dart';
import 'package:bazino/View/BottomNav.dart';
import 'package:url_launcher/url_launcher.dart';


import 'Controller/AddressController.dart';
import 'Controller/DriverinfoController.dart';
import 'Controller/SearchController.dart';
import 'Controller/SocketController.dart';
import 'View/ApppBar.dart';
import 'View/Loading.dart';

class DriverinfoScreen extends StatelessWidget {
  late AddressController addressController;
  late Timer timer;
  var _formKey = GlobalKey<FormState>();
  var _address = "";
  int _eventKey = 0;
  RxDouble lati=32.645.obs;
  RxDouble longi=51.689.obs;
  RxBool getedLoc=false.obs;
  final LocalStorage storage = new LocalStorage('app');
  late final MapController mapController=MapController();
  @override
  Widget build(BuildContext context) {
    // Get.delete<SocketController>();
    SearchController searchController = Get.put(SearchController());
    int UserRef = storage.getItem('UserRef') ?? 0;
    SocketController socketController = Get.arguments[0];
    DriverinfoController driverinfoController = Get.put(DriverinfoController(socketController));

    driverinfoController.DriverLat.value=DriverLat;
    driverinfoController.DriverLong.value=DriverLong;
    socketController.socket.on('update_order', (data){
      print('driveupdate_orderrInfo: ${data["DriverLat"]}');
      driverinfoController.DriverLat.value=data["DriverLat"];
      driverinfoController.DriverLong.value=data["DriverLong"];
    });

    // dynamic arg = Get.arguments;
    // mapController.move(center, zoom);
    // mapController.mapEventStream.listen(onMapEvent);

    // int catref=arg[0]["catref"];

    return WillPopScope(
      onWillPop: () async {
        // Get.offAllNamed("/CategoryScreen");
        return false;
      },
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: Obx((){
          return Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child:  Container(
                        color: Colors.blue,
                        // margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child:FlutterMap(

                          mapController: mapController,
                          options: MapOptions(
                              interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                              center: latLng.LatLng(DriverLat,DriverLong),
                              zoom: 15.0,
                              maxZoom: 18
                          ),

                          layers: [
                            TileLayerOptions(
                              // urlTemplate: "http://map.netnegar.ir/hot/{z}/{x}/{y}.png",
                              urlTemplate: "http://mt0.google.com/vt/lyrs=m&hl=fa&x={x}&y={y}&z={z}",
                              // subdomains: ['a', 'b', 'c'],
                              attributionBuilder: (_) {
                                return Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    // alignment: Alignment.bottomLeft,
                                    child:Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [

                                        Container(
                                          alignment: Alignment.topCenter,
                                          height: 200,
                                         child: Card(
                                           margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                             color: Colors.white,
                                             shape: RoundedRectangleBorder(
                                                 borderRadius: BorderRadius.all(
                                                     Radius.circular(20.0))),
                                             elevation: 6,
                                             child: Container(
                                               padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                               child:  Text("درخواست شما تایید شد و به زودی راننده به محل شما خواهد رسید",style: TextStyle(fontFamily: 'yekan',fontSize: 14),textDirection: TextDirection.rtl,),
                                             )
                                         )
                                        ),
                                         Container(
                                          alignment: Alignment.topCenter,
                                          height: Get.height-440,
                                        ),
                                         Container(
                                           height: 230,
                                           alignment: Alignment.bottomCenter,
                                           margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                             child: Card(
                                               semanticContainer: true,
                                               clipBehavior: Clip.antiAliasWithSaveLayer,
                                               // margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                               color: Colors.white,
                                               shape: RoundedRectangleBorder(
                                                   borderRadius: BorderRadius.all(
                                                       Radius.circular(20.0))),
                                               elevation: 6,
                                               child: Container(

                                                 child: Column(
                                                  children: [
                                                    Container(
                                                      height: 50,
                                                      margin: EdgeInsets.fromLTRB(15, 15, 0, 10),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 2,
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                                                  border: Border.all(color: Colors.black87,)
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                      flex: 3,
                                                                      child:Container(
                                                                          alignment: Alignment.center,
                                                                          child: Text(DriverPelak,style: TextStyle(fontFamily: 'iransans',fontSize: 15,letterSpacing: 2),textDirection: TextDirection.rtl,textAlign: TextAlign.center,))

                                                                  ),
                                                                  Expanded(
                                                                      flex: 1,
                                                                      child:Container(
                                                                        padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                                                                        child: Column(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text("ایران",style: TextStyle(fontFamily: 'iransans'),textDirection: TextDirection.rtl,),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text(DriverPelakCity,style: TextStyle(fontFamily: 'iransans',fontSize: 13),textDirection: TextDirection.rtl,),
                                                                            ),

                                                                          ],
                                                                        ),
                                                                      )

                                                                  )
                                                                ],
                                                              ),
                                                               // color: Colors.blue,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 3,
                                                            child: Container(
                                                              padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                                              alignment: Alignment.centerRight,
                                                              child: Column(
                                                                children: [
                                                                  Expanded(
                                                                      flex:1,
                                                                      child: Text(Drivercar,style: TextStyle(fontFamily: 'yekan',fontWeight: FontWeight.bold,fontSize: 15),textDirection: TextDirection.rtl,)),
                                                                   Expanded(
                                                                      flex:1,
                                                                      child: Text(DriverName,style: TextStyle(fontFamily: 'yekan',fontSize: 14),textDirection: TextDirection.rtl)),

                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                                              child: ClipRRect(
                                                                borderRadius: BorderRadius.circular(50.0),
                                                                child: Image.network(
                                                                  Url + "/images/driver/" +DriverImage,
                                                                  // height: 100.0,
                                                                  // width: 100.0,
                                                                ),
                                                              )
                                                              // Image(image: NetworkImage(Url + "/images/driver/test.jpg" +DriverImage),),
                                                              // NetworkImage(Url + "/images/cat/" + category.Pic)
                                                            ),
                                                          ),

                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                                      height: 60,
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex:1,
                                                            child: TextButton(
                                                                onPressed: () {
                                                                  _makePhoneCall(DriverMobile);
                                                                },
                                                                child: Container(
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                      border: Border.all(color: Colors.green,)
                                                                  ),
                                                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                                  height: 40,
                                                                  width: Get.width,
                                                                  alignment: Alignment.center,
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      Text(
                                                                        "تماس با راننده",
                                                                        style: TextStyle(
                                                                            color: Colors.black87,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: 'yekan'),
                                                                      ),
                                                                      Container(
                                                                          margin: EdgeInsets.fromLTRB(7, 0, 0, 0),
                                                                          child: Icon(Icons.call,color: Colors.green,size: 25,)),
                                                                    ],

                                                                  ),
                                                                )),
                                                          ),
                                                          Expanded(
                                                            flex:1,
                                                            child: TextButton(
                                                                onPressed: () {
                                                                  _makePhoneCall("09137004410");
                                                                },
                                                                child: Container(
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                      border: Border.all(color: Colors.green,)
                                                                  ),
                                                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                                  height: 40,
                                                                  width: Get.width,
                                                                  alignment: Alignment.center,
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      Text(
                                                                        "پشتیبانی",
                                                                        style: TextStyle(
                                                                            color: Colors.black87,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: 'yekan'),
                                                                      ),
                                                                      Container(
                                                                          margin: EdgeInsets.fromLTRB(7, 0, 0, 0),
                                                                          child: Icon(Icons.call,color: Colors.green,size: 25,)),
                                                                    ],

                                                                  ),
                                                                )),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 55,
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex:1,
                                                            child: TextButton(
                                                                onPressed: () {
                                                                  Get.defaultDialog(
                                                                      title: "لغو درخواست",
                                                                      middleText: "آیا از لغو درخواست اطمینان دارید؟",
                                                                      middleTextStyle: TextStyle(fontFamily: 'yekan'),
                                                                      titleStyle: TextStyle(fontFamily: 'yekan'),
                                                                      onConfirm: () {
                                                                        Get.back();
                                                                        Future<int> res = searchController.cancel_request_user();
                                                                        res.then(
                                                                              (int value) {
                                                                            if (value > 0) {
                                                                              Get.back();
                                                                              socketController.socket.emit('cancel_request_user',{'orderref': OrderRef.toString(),'userref': UserRef.toString(),'level': "1", 'key': ApiKeySocket});
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

                                                                      },
                                                                      textConfirm: "لغو درخواست",
                                                                      textCancel: "انصراف",
                                                                      onCancel: () {
                                                                        Get.back();
                                                                      });
                                                                },
                                                                child: Container(
                                                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                                  height: 40,
                                                                  width: Get.width,
                                                                  alignment: Alignment.center,
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      Text(
                                                                        "لغو درخواست",
                                                                        style: TextStyle(
                                                                            color: Colors.black54,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: 'yekan'),
                                                                      ),
                                                                      Container(
                                                                          margin: EdgeInsets.fromLTRB(7, 0, 0, 0),
                                                                          child: Icon(Icons.clear,color: Colors.black54,size: 25,)),
                                                                    ],

                                                                  ),
                                                                )),
                                                          ),
                                                          Expanded(
                                                            flex:1,
                                                            child:
                                                            1==1?Container():
                                                            TextButton(
                                                                onPressed: () {
                                                                  Get.defaultDialog(
                                                                    title:"کد تخفیف را وارد کنید" ,
                                                                      titleStyle: TextStyle(fontFamily: 'yekan',fontSize: 16),
                                                                      titlePadding:EdgeInsets.fromLTRB(0, 10, 0, 10),
                                                                    content: Container(
                                                                      width: Get.width,
                                                                        child:Column(
                                                                          children: [
                                                                            Container(
                                                                              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                                                              child: TextFormField(
                                                                                keyboardType: TextInputType.text,
                                                                                controller: TextEditingController(text: "a"),
                                                                                onSaved: (value) {
                                                                                  // _zayeatT =  double.parse(value!);
                                                                                },
                                                                                style: TextStyle(fontSize: 14, color: BaseColor), textAlign: TextAlign.center,
                                                                                decoration: InputDecoration(
                                                                                  labelStyle: TextStyle(fontFamily: 'yekan'),
                                                                                  alignLabelWithHint: true,
                                                                                  hintTextDirection: TextDirection.rtl,
                                                                                  filled: true,
                                                                                  border: OutlineInputBorder(),
                                                                                  enabledBorder: OutlineInputBorder(
                                                                                    borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none,
                                                                                  ),
                                                                                  focusedBorder: OutlineInputBorder(
                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                      borderSide: BorderSide(color: BaseColor)),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              child: Row(children: [

                                                                                Expanded(
                                                                                  flex:1,
                                                                                  child:  Container(
                                                                                      margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                                                                                      decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                                          border: Border.all(color: Colors.green,)
                                                                                      ),
                                                                                      child:TextButton(
                                                                                          onPressed: () {
                                                                                            Get.offAllNamed("/CategoryScreen");
                                                                                          },
                                                                                          child: Container(
                                                                                            alignment: Alignment.center,
                                                                                            child: Text(
                                                                                              "انصراف",
                                                                                              style: TextStyle(
                                                                                                  color: Colors.black54,
                                                                                                  fontWeight: FontWeight.bold,
                                                                                                  fontFamily: 'yekan'),
                                                                                            ),
                                                                                          ))),
                                                                                ),
                                                                                Expanded(
                                                                                  flex:1,
                                                                                  child: Container(
                                                                                      margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                                                                                      decoration: new BoxDecoration(
                                                                                        color: BaseColor,
                                                                                        borderRadius: BorderRadius.all( Radius.circular(10)),
                                                                                      ),
                                                                                      child:TextButton(
                                                                                          onPressed: () {
                                                                                            Get.back();
                                                                                          },
                                                                                          child: Container(
                                                                                            alignment: Alignment.center,
                                                                                            child: Text(
                                                                                              "ثبت کد",
                                                                                              style: TextStyle(
                                                                                                  color: Colors.white,
                                                                                                  fontWeight: FontWeight.bold,
                                                                                                  fontFamily: 'yekan'),
                                                                                            ),
                                                                                          ))),
                                                                                ),

                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ))
                                                                  );
                                                                },
                                                                child: Container(

                                                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                                  height: 40,
                                                                  width: Get.width,
                                                                  alignment: Alignment.center,
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      Text(
                                                                        "کد تخفیف",
                                                                        style: TextStyle(
                                                                            color: Colors.green,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: 'yekan'),
                                                                      ),
                                                                      Container(
                                                                          margin: EdgeInsets.fromLTRB(7, 0, 0, 0),
                                                                          child: Icon(Icons.price_change,color: Colors.green,size: 25,)),
                                                                    ],

                                                                  ),
                                                                )),
                                                          ),

                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                 ),
                                               ),
                                             ),
                                           ),


                                      ],
                                    )
                                );
                              },
                            ),
                            MarkerLayerOptions(
                              markers: [

                                Marker(

                                  anchorPos: AnchorPos.align(AnchorAlign.top),
                                  // width: 30.0,
                                  // height: 30.0,
                                  point: latLng.LatLng(driverinfoController.DriverLat.value,driverinfoController.DriverLong.value),
                                  builder: (ctx) =>
                                      Container(
                                        child: Icon(Icons.car_repair_rounded,color: BaseColor,size: 48,),
                                      ),
                                ),
                                Marker(
                                  anchorPos: AnchorPos.align(AnchorAlign.top),
                                  // width: 30.0,
                                  // height: 30.0,
                                  point: latLng.LatLng(UserLat,UserLong),
                                  builder: (ctx) =>
                                      Container(
                                        child: Icon(Icons.location_history,color: Colors.blue,size: 48,),
                                      ),
                                ),
                              ],
                            ),
                          ],
                        )
                    ),
                  ),


                ],
              ),
            ),
          );
        }),


      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }
}
