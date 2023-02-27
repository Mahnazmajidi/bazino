import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:get/get.dart';
import 'package:bazino/utils/constants.dart';
import 'package:bazino/View/BottomNav.dart';


import 'Controller/AddressController.dart';
import 'View/ApppBar.dart';
import 'View/Loading.dart';

class EditAddressScreen extends StatelessWidget {
  late AddressController addressController;

  var _formKey = GlobalKey<FormState>();
  var _address = "";
  int _eventKey = 0;
  RxDouble lati=32.645.obs;
  RxDouble longi=51.689.obs;
  RxBool getedLoc=false.obs;
  late final MapController mapController=MapController();
  @override
  Widget build(BuildContext context) {
    addressController = Get.put(AddressController());
    dynamic arg = Get.arguments;
    print(arg[0].toString()+"______LAT");
    lati.value=arg[1];
    longi.value=arg[2];
    // mapController.move(center, zoom);
    mapController.mapEventStream.listen(onMapEvent);

    // int catref=arg[0]["catref"];

    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed("/UserAddressScreen");
        return true;
      },
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: Obx((){
          return Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  ApppBar(title: "ویرایش", back: "/UserAddressScreen"),

                  Expanded(
                    flex: 1,
                    child:  Container(
                        color: Colors.blue,
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child:FlutterMap(

                          mapController: mapController,
                          options: MapOptions(
                              interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                              center: latLng.LatLng(arg[1],arg[2]),
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
                                  margin: EdgeInsets.fromLTRB(15, 0, 0, 15),
                                  alignment: Alignment.bottomLeft,
                                    child:InkWell(
                                        onTap: (){
                                          moveToCurrent();
                                        },
                                        child: getedLoc.value?Icon(Icons.my_location,size: 35,color: Colors.blue,):Icon(Icons.my_location,size: 35,color: Colors.black54,))
                                );
                              },
                            ),
                            MarkerLayerOptions(
                              markers: [
                                Marker(
                                  anchorPos: AnchorPos.align(AnchorAlign.top),
                                  // width: 30.0,
                                  // height: 30.0,
                                  point: latLng.LatLng(lati.value,longi.value),
                                  builder: (ctx) =>
                                      Container(
                                        child: Icon(Icons.location_on,color: BaseColor,size: 48,),
                                      ),
                                )
                              ],
                            ),
                          ],
                        )
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.fromLTRB(0, 15, 20, 10),
                    child: Text(
                      "آدرس:",
                      style: TextStyle(
                        fontFamily: "yekan",
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        // maxLines: null,
                        minLines: 2,
                        //Normal textInputField will be displayed
                        maxLines: 5,
                        controller: TextEditingController(text: arg[3]),
                        onSaved: (value) {
                          _address = value!;
                        },
                        validator: (value) {
                          if (value == "") {
                            return 'آدرس تحویل سفارش را وارد کنید';
                          } else if (value!.length < 3) {
                            return 'آدرس را به صورت دقیق وارد کنید';
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(fontSize: 14, color: Colors.black87,fontFamily: 'yekan'),
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          // labelText: "آدرس:",
                          labelStyle: TextStyle(fontFamily: 'yekan'),
                          alignLabelWithHint: true,
                          hintTextDirection: TextDirection.rtl,
                          filled: true,
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: BaseColor)),
                          prefixIcon: Icon(Icons.location_history_rounded),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: BaseColor,
                    width: Get.width,
                    height: 60,
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child:   addressController.geted==1?Container(
                      color: BaseColor,
                      height: 60,
                      width: Get.width,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(color: Colors.white,),
                    ):TextButton(

                        onPressed: () {
                          _formKey.currentState!.save();
                          if(_formKey.currentState!.validate()){
                            if(lati.value==32.645 && longi.value==51.689){
                              Get.snackbar("..", "..",
                                  titleText: Text("خطا",textAlign: TextAlign.right,style: TextStyle(color:Colors.white,fontFamily: 'yekan'),),
                                  messageText: Text("موقعیت خود را از روی نقشه انتخاب کنید",textAlign: TextAlign.right,style: TextStyle(color:Colors.white,fontFamily: 'yekan',fontSize: 16),),
                                  backgroundColor:Colors.black,
                                  icon: Icon(Icons.error,color: Colors.red,textDirection: TextDirection.rtl,),
                                  duration: Duration(seconds: 3),
                                  // snackPosition: SnackPosition.BOTTOM,
                                  overlayColor: Colors.grey.withOpacity(0.5 ),
                                  dismissDirection: DismissDirection.horizontal,
                                  overlayBlur: 1,
                                  colorText: Colors.white);
                            }
                            else{
                              addressController.editAddress(arg[0],lati.value,longi.value,_address).then((int res) {
                                if (res == 0) {
                                  Get.defaultDialog(
                                    title: "خطا",
                                    middleText: addressController.msg.value,
                                    middleTextStyle: TextStyle(fontFamily: 'yekan'),
                                    titleStyle: TextStyle(fontFamily: 'yekan'),
                                    onConfirm: () {
                                      Get.back();
                                    },
                                    textConfirm: "قبول",
                                  );
                                }
                                else{
                                  print("OKKKK_____");
                                  Get.offAllNamed("/AddressScreen");

                                }
                              });
                            }
                          }



                        },
                        child: Container(
                          color: BaseColor,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),

                          height: 60,
                          width: Get.width,
                          alignment: Alignment.center,
                          child: Row(

                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "ویرایش آدرس",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'yekan'),
                              ),
                              Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Icon(Icons.location_on_outlined,color: Colors.white,size: 25,)),
                            ],

                          ),
                        )),
                  )

                ],
              ),
            ),
          );
        }),


      ),
    );
  }
  void moveToCurrent() async {
    _eventKey++;
    var location = Location();

    try {
      var currentLocation = await location.getLocation();


      var moved = mapController.move(
        LatLng(currentLocation.latitude!, currentLocation.longitude!),
        17,
        id: _eventKey.toString(),
      );

      if (moved) {
        lati.value=currentLocation.latitude!;
        longi.value=currentLocation.longitude!;
        setmarker(lati.value,longi.value);
        // LatLng ltn=LatLng(this.lati.value,this.longi.value);
        // print(lati.value.toString()+","+longi.value.toString());
        // mapController.move(ltn, 15);

        // setIcon(Icons.gps_fixed);
      // } else {
        // setIcon(Icons.gps_not_fixed);
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar("..", "..",
          titleText: Text("خطا",textAlign: TextAlign.right,style: TextStyle(color:Colors.white,fontFamily: 'yekan'),),
          messageText: Text("GPS گوشی شما خاموش است",textAlign: TextAlign.right,style: TextStyle(color:Colors.white,fontFamily: 'yekan',fontSize: 16),),
          backgroundColor:Colors.black,
          icon: Icon(Icons.error,color: Colors.red,textDirection: TextDirection.rtl,),
          duration: Duration(seconds: 3),
          // snackPosition: SnackPosition.BOTTOM,
          overlayColor: Colors.grey.withOpacity(0.5 ),
          dismissDirection: DismissDirection.horizontal,
          overlayBlur: 1,
          colorText: Colors.white);
    }
  }
  void setmarker(double latii,double longii) {
    Future.delayed(const Duration(milliseconds: 5), () {

// Here you can write your code
      lati.value=latii;
      longi.value=longii;
      getedLoc.value=true;
      print("Delay__");

    });

  }
  void onMapEvent(MapEvent mapEvent) {
    // print(mapEvent.id.toString());
    // print(mapEvent);
    if (mapEvent is MapEventMove ) {
      // print(mapEvent);
      print(mapEvent.center);
      lati.value=mapEvent.center.latitude;
      longi.value=mapEvent.center.longitude;
      // setIcon(Icons.gps_not_fixed);
    }
  }

}
