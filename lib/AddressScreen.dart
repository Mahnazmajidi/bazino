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
import 'Model/AddressModel.dart';
import 'View/ApppBar.dart';
import 'View/Loading.dart';
import 'View/MyDrawer.dart';

class AddressScreen extends StatelessWidget {
  late AddressController addressController;

  var _formKey = GlobalKey<FormState>();
  var _formKeyBottom = GlobalKey<FormState>();
  var _addressname = "";
  int _eventKey = 0;
  RxDouble lati=32.645.obs;
  RxDouble longi=51.689.obs;
  RxBool getedLoc=false.obs;
  RxDouble currentlat=0.0.obs;
  RxDouble currentlong=0.0.obs;
  RxInt FirstChange=0.obs;
  late final MapController mapController=MapController();
  @override
  Widget build(BuildContext context) {
    addressController = Get.put(AddressController());
    // dynamic arg = Get.arguments;
    // mapController.move(center, zoom);
    mapController.mapEventStream.listen(onMapEvent);
    // moveToCurrent();
    // int catref=arg[0]["catref"];
    autoLoc().then((value){
      // after auto
    });

    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed("/FactorScreen");
        return false;
      },
      child: Scaffold(
        endDrawer:MyDrawer(),
        // backgroundColor: Colors.white,
        body: Obx((){
          return Container(
            child: Column(
              children: [
                ApppBar(title: "انتخاب موقعیت", back: "/FactorScreen"),

                Expanded(
                  flex: 1,
                  child:  Container(
                      color: Colors.blue,
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child:FlutterMap(

                        mapController: mapController,
                        options: MapOptions(
                            interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                            center: latLng.LatLng(32.645,51.689),
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
                                // margin: EdgeInsets.fromLTRB(15, 0, 0, 15),
                                alignment: Alignment.bottomRight,
                                  child:Column(
                                    children: [
                                      Container(
                                        height: 60,

                                        width: Get.width,
                                        child: Container(
                                          width: Get.width,
                                          height: 220,
                                          margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                                          child:addressController.geted==1?Container():ListView.builder(
                                            physics: ClampingScrollPhysics(),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            reverse: true,
                                            // scrollDirection: Axis.horizontal,
                                            itemCount:
                                            addressController.address.length,
                                            itemBuilder: (context, position) {
                                              return genItem(
                                                  addressController.address[position],
                                                  position);
                                            },
                                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container()
                                        ),
                                        Container(
                                          height: 100,
                                          margin: EdgeInsets.fromLTRB(0, 0, 10, 20),
                                          alignment: Alignment.bottomRight,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(25.0))),
                                            child: Container(
                                              padding: EdgeInsets.all(7),
                                              child: InkWell(
                                                  onTap: (){
                                                    moveToCurrent();
                                                  },
                                                  child: getedLoc.value?Icon(Icons.my_location,size: 35,color: Colors.blue,):Icon(Icons.my_location,size: 35,color: Colors.black54,)
                                              ),
                                            ),
                                          ),
                                        )
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
                  color: BaseColor,
                  width: Get.width,
                  height: 60,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child:
                  ElevatedButton(
                    style:ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(BaseColor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              // borderRadius: BorderRadius.circular(18.0),
                              // side: BorderSide(color: Colors.red),
                            )
                        )
                    ) ,
                    onPressed: () {
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
                        UserLat=lati.value;
                        UserLong=longi.value;
                        Get.defaultDialog(
                            barrierDismissible: false,
                            onWillPop: ()async{
                              Get.offAllNamed("/AddressScreen");
                              return false;
                            },
                            title:"" ,
                            titlePadding: EdgeInsets.all(0),
                            custom: Container(),

                            titleStyle: TextStyle(fontFamily: 'yekan',fontSize: 16,fontWeight: FontWeight.bold),
                            // titlePadding:EdgeInsets.fromLTRB(0, 20, 0, 10),
                            content: Form(
                              key: _formKey,
                              child: Container(
                                  width: Get.width,
                                  child:Column(
                                    children: [
                                      Container(
                                          alignment:Alignment.centerRight,
                                          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                          child:InkWell(
                                              onTap: (){
                                                Get.back();
                                              },
                                              child: Icon(Icons.clear,size: 25,)
                                          )

                                      ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                    child:Text("اطلاعات آدرس", style: TextStyle(fontFamily: 'yekan',fontSize: 14,color: Colors.black87,fontWeight: FontWeight.bold), textDirection: TextDirection.rtl),
                                  ),
                                      Container(
                                          margin: EdgeInsets.fromLTRB(15, 5, 15, 10),
                                          child:Column(
                                            children: [
                                              Container(
                                                alignment: Alignment.centerRight,
                                                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                                child: Directionality(
                                                  textDirection: TextDirection.rtl,
                                                  child: TextFormField(
                                                    controller: TextEditingController(text:UserName),
                                                    keyboardType: TextInputType.emailAddress,
                                                    onSaved: (value) {
                                                      UserName = value!;
                                                    },
                                                    validator: (value) {
                                                      if (value == null) {
                                                        return 'نام و نام خانوادگی تحویل دهنده بازیافت را وارد کنید';
                                                      }
                                                      else if (value.length <3) {
                                                        return 'نام و نام خانوادگی تحویل دهنده بازیافت را به درستی وارد کنید';
                                                      }
                                                      else {
                                                        return null;
                                                      }
                                                    },
                                                    style:
                                                    TextStyle(fontSize: 14, color: Colors.black87, fontFamily: 'yekan'),
                                                    textAlign: TextAlign.right,

                                                    decoration: InputDecoration(
                                                      labelText: "نام و نام خانوادگی تحویل دهنده",
                                                      labelStyle: TextStyle(
                                                          fontFamily: 'yekan'),
                                                      alignLabelWithHint: true,
                                                      hintTextDirection: TextDirection.rtl,
                                                      filled: true,
                                                      border: OutlineInputBorder(),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(10),
                                                        borderSide: BorderSide.none,
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(
                                                              10),
                                                          borderSide: BorderSide(
                                                              color: Colors.black54)),
                                                      prefixIcon: Icon(Icons.person),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.centerRight,
                                                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                                child: Directionality(
                                                  textDirection: TextDirection.rtl,
                                                  child: TextFormField(
                                                    controller: TextEditingController(text:UserMobile),
                                                    keyboardType: TextInputType.phone,
                                                    onSaved: (value) {
                                                      UserMobile = value!;
                                                    },
                                                    validator: (value) {
                                                      if (value == null) {
                                                        return 'شماره همراه تحویل دهنده بازیافت را وارد کنید';
                                                      }
                                                      else if (value.length != 11) {
                                                        return 'شماره همراه تحویل دهنده بازیافت را به درستی وارد کنید';
                                                      }
                                                      else {
                                                        return null;
                                                      }
                                                    },
                                                    style:
                                                    TextStyle(fontSize: 14, color: Colors.black87),
                                                    textAlign: TextAlign.left,
                                                    decoration: InputDecoration(
                                                      labelText: "شماره موبایل تحویل دهنده",
                                                      labelStyle: TextStyle(
                                                          fontFamily: 'yekan'),
                                                      alignLabelWithHint: true,
                                                      hintTextDirection: TextDirection.ltr,
                                                      filled: true,
                                                      border: OutlineInputBorder(),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(10),
                                                        borderSide: BorderSide.none,
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(
                                                              10),
                                                          borderSide: BorderSide(
                                                              color: Colors.black54)),
                                                      prefixIcon: Icon(Icons.phone_android_sharp),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.centerRight,
                                                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                                child: Directionality(
                                                  textDirection: TextDirection.rtl,
                                                  child: TextFormField(
                                                    validator: (value) {
                                                      if (value == null) {
                                                        return 'آدرس تحویل بازیافت را وارد کنید';
                                                      }
                                                      else {
                                                        return null;
                                                      }
                                                    },
                                                    keyboardType: TextInputType.multiline,
                                                    minLines: 2,//Normal textInputField will be displayed
                                                    maxLines: 5,// when user presses enter it will adapt to it
                                                    onSaved: (value) {
                                                      UserAddress = value!;
                                                    },
                                                    style:
                                                    TextStyle(fontSize: 14, color: Colors.black87,fontFamily: 'yekan'),
                                                    textAlign: TextAlign.right,
                                                    decoration: InputDecoration(
                                                      labelText: "آدرس",
                                                      labelStyle: TextStyle(
                                                          fontFamily: 'yekan'),
                                                      alignLabelWithHint: true,
                                                      hintTextDirection: TextDirection.rtl,
                                                      filled: true,
                                                      border: OutlineInputBorder(),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(10),
                                                        borderSide: BorderSide.none,
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(
                                                              10),
                                                          borderSide: BorderSide(
                                                              color: Colors.black54)),
                                                      prefixIcon: Icon(Icons.pending_outlined),
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex:1,
                                                    child:  Container(
                                                      margin: EdgeInsets.fromLTRB(0, 10, 5, 0),
                                                      child: ElevatedButton(
                                                        style:ButtonStyle(
                                                            backgroundColor: MaterialStateProperty.all<Color>(BaseColor),
                                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                  // side: BorderSide(color: Colors.red),
                                                                )
                                                            )
                                                        ) ,
                                                        onPressed: () {
                                                          _formKey.currentState!.save();
                                                          Get.offAllNamed("/SearchScreen");
                                                        },
                                                        child: addressController.geted.value==1?CircularProgressIndicator(color:Colors.white):
                                                        Text("تایید آدرس", style: TextStyle(fontFamily: 'yekan',fontSize: 14,color: Colors.white,), textDirection: TextDirection.rtl),
                                                      ),
                                                    ),
                                                  ),Expanded(
                                                    flex:1,
                                                    child: Container(
                                                      margin: EdgeInsets.fromLTRB(5, 10, 0, 0),
                                                      child: ElevatedButton(
                                                        style:ButtonStyle(
                                                            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                  side: BorderSide(color: Colors.black45),
                                                                )
                                                            )
                                                        ) ,
                                                        onPressed: () {
                                                          _formKey.currentState!.save();
                                                          if(_formKey.currentState!.validate()){
                                                            Get.bottomSheet(
                                                                Obx((){
                                                                  return Container(
                                                                      decoration: new BoxDecoration(
                                                                          color: Colors.white,
                                                                          borderRadius: new BorderRadius.only(
                                                                              topLeft: const Radius.circular(20.0),
                                                                              topRight: const Radius.circular(20.0))),
                                                                      height: 310,
                                                                      child: Form(
                                                                        key: _formKeyBottom,
                                                                        child: Container(
                                                                            width: Get.width,
                                                                            child:Column(
                                                                              children: [
                                                                                Container(
                                                                                    alignment:Alignment.centerRight,
                                                                                    padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
                                                                                    child:InkWell(
                                                                                        onTap: (){
                                                                                          Get.back();
                                                                                        },
                                                                                        child: Icon(Icons.clear,size: 25,)
                                                                                    )

                                                                                ),
                                                                                Container(
                                                                                    alignment:Alignment.center,
                                                                                    margin: EdgeInsets.fromLTRB(15, 5, 15, 10),
                                                                                    child:Text(
                                                                                      "یک نام دلخواه برای آدرس منتخب وارد کنید ",
                                                                                      style: TextStyle(color: Colors.black87,  fontFamily: 'yekan',fontWeight: FontWeight.bold,fontSize: 16),
                                                                                      textDirection: TextDirection.rtl,
                                                                                    )

                                                                                ),
                                                                                Container(
                                                                                  margin: EdgeInsets.fromLTRB(25, 20, 25, 20),
                                                                                  height: 55,
                                                                                  decoration: BoxDecoration(
                                                                                    // color: BaseColor,
                                                                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                                                                      border: Border.all(color: Colors.black26,)
                                                                                  ),
                                                                                  child: Container(
                                                                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                                                    alignment: Alignment.centerLeft,
                                                                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                                                    child: TextFormField(
                                                                                      decoration: new InputDecoration(
                                                                                        contentPadding: EdgeInsets.zero,
                                                                                        border: InputBorder.none,
                                                                                        focusedBorder: InputBorder.none,
                                                                                        enabledBorder: InputBorder.none,
                                                                                        errorBorder: InputBorder.none,
                                                                                        disabledBorder: InputBorder.none,
                                                                                        counterText: "",
                                                                                      ),
                                                                                      textAlign: TextAlign.center,
                                                                                      keyboardType: TextInputType.text,
                                                                                      style: TextStyle(fontSize: 22.0,color: Colors.black87,fontFamily: 'yekan',),
                                                                                      maxLength: 11,
                                                                                      // controller: TextEditingController(text: walletController.addPrice.value),
                                                                                      onSaved: (value) {
                                                                                        _addressname = value!;
                                                                                      },
                                                                                      validator: (value) {
                                                                                        if (value == null) {
                                                                                          return 'نام آدرس منتخب وارد نشده است';
                                                                                        }
                                                                                        else if (value.length <1) {
                                                                                          return 'نام آدرس منتخب وارد نشده است';
                                                                                        }
                                                                                        else {
                                                                                          return null;
                                                                                        }
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  width:Get.width,
                                                                                  height:50,
                                                                                  margin: EdgeInsets.fromLTRB(25, 10, 25,10),
                                                                                  child:  ElevatedButton(
                                                                                    style:ButtonStyle(
                                                                                        backgroundColor: MaterialStateProperty.all<Color>(BaseColor),
                                                                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                                            RoundedRectangleBorder(
                                                                                              borderRadius: BorderRadius.circular(18.0),
                                                                                              // side: BorderSide(color: Colors.red),
                                                                                            )
                                                                                        )
                                                                                    ) ,
                                                                                    onPressed: () {
                                                                                      _formKeyBottom.currentState!.save();
                                                                                      if(_formKeyBottom.currentState!.validate()){
                                                                                        addressController.newAddress(lati.value,longi.value,_addressname).then((int res) {

                                                                                          if (res == 0) {
                                                                                            Get.snackbar("..", "..",
                                                                                                titleText: Text("خطا",textAlign: TextAlign.right,style: TextStyle(color:Colors.white,fontFamily: 'yekan'),),
                                                                                                messageText: Text("خطا در ثبت آدرس جدید",textAlign: TextAlign.right,style: TextStyle(color:Colors.white,fontFamily: 'yekan',fontSize: 16),),
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
                                                                                            print("YYYYYYEEESSS");
                                                                                            Get.back();
                                                                                            Get.snackbar("..", "..",
                                                                                                titleText: Text("موفقیت آمیز", textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontFamily: 'yekan'),),
                                                                                                messageText: Text("آدرس با موفقیت ذخیره شد", textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontFamily: 'yekan', fontSize: 16),),
                                                                                                backgroundColor: Colors.black,
                                                                                                icon: Icon(Icons.check_circle, color: Colors.green, textDirection: TextDirection.rtl,),
                                                                                                duration: Duration(seconds: 5),
                                                                                                //     snackPosition: SnackPosition.BOTTOM,
                                                                                                overlayColor: Colors.grey.withOpacity(0.5),
                                                                                                dismissDirection:
                                                                                                DismissDirection.horizontal,
                                                                                                overlayBlur: 1,
                                                                                                colorText: Colors.white);


                                                                                          }
                                                                                        });
                                                                                      }
                                                                                      else{
                                                                                        print("EMPTYYYYY");
                                                                                      }

                                                                                    },
                                                                                    child:
                                                                                    addressController.getedNew.value==1?Container(
                                                                                        padding: EdgeInsets.fromLTRB(5, 5, 5 ,5),
                                                                                        child: CircularProgressIndicator(color:Colors.black54)):
                                                                                    Text("تایید", style: TextStyle(fontFamily: 'yekan',fontSize: 14,color: Colors.white,), textDirection: TextDirection.rtl),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                      )
                                                                  );
                                                                })
                                                                ,shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(30.0),
                                                            )
                                                            );
                                                          }
                                                        },
                                                        child:
                                                        Text("ذخیره آدرس", style: TextStyle(fontFamily: 'yekan',fontSize: 14,color: Colors.black87,), textDirection: TextDirection.rtl),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                      ),

                                    ],
                                  )),
                            )
                        );
                      }
                    },
                    child:
                    Row(

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "تایید موقعیت",
                          style: TextStyle(
                            fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'yekan'),
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Icon(Icons.add_location_alt_outlined,color: Colors.white,size: 25,)),
                      ],

                    ),
                  ),
                )

              ],
            ),
          );
        }),


      ),
    );
  }
  Future <int> autoLoc() async{
    Location location = Location();
    await location.getLocation().then((vv) {
        var moved = mapController.move(
          LatLng(vv.latitude!, vv.longitude!), 17, id: _eventKey.toString(),
        );
        if (moved) {
          lati.value=vv.latitude!;
          longi.value=vv.longitude!;
          setmarker(lati.value,longi.value);
        }
      }
    );
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled().then((value){
      print("AAAAkkkkkk");
      return true;
    });
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService().then((value){
        return true;
      });
      location.onLocationChanged.listen((LocationData cLocation) {
          var moved = mapController.move(
            LatLng(cLocation.latitude!, cLocation.longitude!),
            17,
            id: _eventKey.toString(),
          );
          if (moved) {
            lati.value=cLocation.latitude!;
            longi.value=cLocation.longitude!;
            setmarker(lati.value,longi.value);
          }
      });
      return 1;
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return 6 ;
      }
    }
    return 7;
  }

  void moveToCurrent() async {
    print("AUTO LOC_____");
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
  InkWell genItem(AddressModel addressModel, int position) {
    return InkWell(
      // splashColor: Colors.white,
      onTap: () {
        lati.value=addressModel.Lati;
        longi.value=addressModel.Longi;
        mapController.move(
          LatLng(lati.value, longi.value),
          17,
          id: _eventKey.toString(),
        );
        setmarker(lati.value,longi.value);
      },
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        elevation: 1,
        child:   Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            // margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
            alignment: Alignment.centerRight,
            child:
            Row(
              children: [
                Text(addressModel.AddressName, style: TextStyle(fontFamily: 'yekan',fontSize: 14,color: Colors.black87), textDirection: TextDirection.rtl,),
                Container(
                    margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Icon(Icons.star,color: BaseColor,size: 20,))
              ],
            )
        ),
      ),
    );
  }

}
