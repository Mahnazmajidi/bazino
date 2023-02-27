import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazino/utils/constants.dart';
import 'Controller/AddressController.dart';
import 'Model/AddressModel.dart';
import 'View/ApppBar.dart';
import 'View/Loading.dart';
import 'View/MyDrawer.dart';

class UserAddressScreen extends StatelessWidget {
  late AddressController addressController;
  var _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    dynamic arg = Get.arguments;
    // int catref=arg[0]["catref"];
    addressController = Get.put(AddressController());
    addressController.setAddress().then((int res) {
      if (res == 0) {
        Get.defaultDialog(
          title: "خطا",
          middleText: addressController.msg.value,
          middleTextStyle: TextStyle(fontFamily: 'yekan'),
          titleStyle: TextStyle(fontFamily: 'yekan'),
          onConfirm: () {
            addressController.setAddress().then((int res) {
              if (res == 0) {
                Get.defaultDialog(
                    title: "خطا",
                    middleText: addressController.msg.value,
                    middleTextStyle: TextStyle(fontFamily: 'yekan'),
                    titleStyle: TextStyle(fontFamily: 'yekan'),
                    onConfirm: () {
                      Get.offAllNamed("/CategoryScreen");
                    },
                    textConfirm: "تلاش مجدد",
                    textCancel: "بازگشت",
                    onCancel: () {
                      Get.offAllNamed("/CategoryScreen");
                    });
              }
            });
          },
          textConfirm: "تلاش مجدد",
          textCancel: "بازگشت",
          onCancel: () {

            Get.offAllNamed("/CategoryScreen");
          },
        );
      }
    });
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed("/FactorScreen");
        return false;
      },
      child: Scaffold(
        endDrawer:MyDrawer(),
        // backgroundColor: Colors.white,
        body: Obx(() {
          return Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  ApppBar(title: "آدرس های منتخب", back: "/FactorScreen"),
                  Container(child: Icon(Icons.location_on_outlined,color: BaseColor,size: 95,),),
                  // Container(
                  //   margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  //   child: Text("آدرس های منتخب شما",style: TextStyle(fontFamily: 'yekan'),),),
                  //
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: addressController.geted.value == 0
                          ? Container()
                          : addressController.geted.value == 1
                          ? Loading()
                          : ListView.builder(
                        itemCount: addressController.address.length,
                        itemBuilder: (context, position) {
                          return genItem(
                              addressController.address[position],position,addressController);
                        },
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    width: Get.width,
                    height: 40,
                    child:   TextButton(

                        onPressed: () {
                         Get.toNamed("/NewAddressScreen");
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
                                "آدرس جدید",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'yekan'),
                              ),
                              Container(
                                  margin: EdgeInsets.fromLTRB(7, 0, 0, 0),
                                  child: Icon(Icons.add_location_alt_outlined,color: Colors.black87,size: 25,)),
                            ],

                          ),
                        )),
                  ),
                Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    alignment: Alignment.center,
                    width: 110,
                    child: Divider(color: Colors.black87,)),
                Container(
                  color: BaseColor,
                  width: Get.width,
                  height: 60,
                  child:   TextButton(
                      onPressed: () {
                          print(basketGlob.toString());
                          Get.offAllNamed("/HomeScreen");
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
                            Container(
                                margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                                child: Icon(Icons.arrow_back,color: Colors.white,size: 30,)),
                            Text(
                              "بازگشت",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'yekan'),
                            ),

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
  Card genItem(AddressModel address, int position,AddressController addressC) {
    if(address.ID==AddressRef){
      address.selected.value=true;
    }
    return Card(
        margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        elevation: 6,
      child: Obx((){
        return Container(
          height: 90,
          padding: EdgeInsets.fromLTRB(0, 10, 5, 10),
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: (){
                  Get.defaultDialog(
                    title: "حذف آدرس",
                    titleStyle: TextStyle(fontFamily: 'yekan'),
                    middleText:"از حذف آدرس اطمینان دارید؟",
                    middleTextStyle: TextStyle(fontFamily: 'yekan'),
                    onConfirm: () {
                      Get.back();
                      addressController.deleteAddress(address.ID).then((int res) {
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
                    },
                    textConfirm: "حذف",
                    textCancel: "انصراف",
                    onCancel: () {
                      Get.back();
                    },
                  );

                },
                child: Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
                    child: Icon(Icons.delete)),
              ),
              InkWell(
                onTap: (){
                  print(address.Lati.toString()+"____LATI1");
                  Get.offAllNamed("/EditAddressScreen",arguments: [address.ID,address.Lati,address.Longi,address.Address]);
                },
                child: Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
                    child: Icon(Icons.edit)),
              ),

              Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: (){
                      UserLat=address.Lati;
                      UserLong=address.Longi;
                      AddressRef=address.ID;
                      for(int i=0;i<addressC.address.length;i++){
                        addressC.address[i].selected.value=false;
                      }
                      if(address.selected.value){
                        address.selected.value=false;
                      }
                      else{
                        address.selected.value=true;
                      }
                    },
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(address.Address,style: TextStyle(fontFamily: 'yekan'), textDirection: TextDirection.rtl,)),
                  )),

              InkWell(
                onTap: (){
                  UserLat=address.Lati;
                  UserLong=address.Longi;
                  AddressRef=address.ID;
                  for(int i=0;i<addressC.address.length;i++){
                    addressC.address[i].selected.value=false;
                  }
                  if(address.selected.value){
                    address.selected.value=false;

                  }
                  else{
                    address.selected.value=true;
                  }
                },
                child: Container(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: address.selected.value
                        ? Icon(Icons.check_circle,color: Colors.green,)
                        :Icon(Icons.circle_outlined)),
              ),

            ],
          ),
        );
      }),


    );
  }

}
