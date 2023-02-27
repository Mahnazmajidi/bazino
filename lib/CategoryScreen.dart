import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazino/utils/constants.dart';
import 'package:bazino/View/BottomNav.dart';
import 'package:localstorage/localstorage.dart';

import 'Controller/CategoryController.dart';
import 'Model/CategoryModel.dart';
import 'View/ApppBar.dart';
import 'View/Loading.dart';
import 'View/MyDrawer.dart';

class CategoryScreen extends StatelessWidget {
  late CategoryController productController;
  var _formKey = GlobalKey<FormState>();

  final LocalStorage storage = new LocalStorage('app');
  @override
  Widget build(BuildContext context) {
    DiscountCode="";
    int UserRef = storage.getItem('UserRef') ?? 0;
    if(UserRef==0){
      UserRef=UserRefHelper;
    }
    dynamic arg = Get.arguments;
    // int catref=arg[0]["catref"];
    productController = Get.put(CategoryController());
    productController.setCategory().then((int res) {
      if (res == 0) {
        Get.defaultDialog(
          title: "خطا",
          middleText: productController.msg.value,
          middleTextStyle: TextStyle(fontFamily: 'yekan'),
          titleStyle: TextStyle(fontFamily: 'yekan'),
          onConfirm: () {
            productController.setCategory().then((int res) {
              if (res == 0) {
                Get.defaultDialog(
                    title: "خطا",
                    middleText: productController.msg.value,
                    middleTextStyle: TextStyle(fontFamily: 'yekan'),
                    titleStyle: TextStyle(fontFamily: 'yekan'),
                    onConfirm: () {
                      Get.toNamed("/CategoryScreen");
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
        Get.offAllNamed("/HomeScreen");
        return true;
      },
      child: Scaffold(
        // backgroundColor: Colors.white,
        endDrawer:MyDrawer(),
        body: Obx(() {
          return Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  ApppBar(title: "انتخاب نوع بازیافت", back: "/HomeScreen"),
                  Expanded(
                    flex: 1,
                    child: Card(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      elevation: 6,
                      child: productController.geted.value == 0
                          ? Container()
                          : productController.geted.value == 1
                          ? Loading()
                          : ListView.builder(
                        itemCount: productController.product.length,
                        itemBuilder: (context, position) {
                          return genItem(
                              productController.product[position],
                              position);
                        },
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      ),
                    ),
                  ),
                   Container(
                     alignment: Alignment.centerRight,
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                        child:  TextButton(
                                onPressed: () {

                                  if(UserRef==0){
                                    Get.toNamed("/ProfileScreen");
                                  }
                                  else{
                                    _formKey.currentState!.save();
                                    bool chcek=false;
                                    print(basketGlob.toString());
                                    basketGlob.forEach((key, value) {
                                      if(key!="" && value!=""){
                                        chcek=true;
                                      }
                                    });
                                    if(chcek){
                                      Get.toNamed("/FactorScreen");
                                    }
                                    else{
                                      Get.snackbar("..", "..",
                                          titleText: Text("خطا",textAlign: TextAlign.right,style: TextStyle(color:Colors.white,fontFamily: 'yekan'),),
                                          messageText: Text("نوع و مقدار بازیافت خود را وارد کنید",textAlign: TextAlign.right,style: TextStyle(color:Colors.white,fontFamily: 'yekan',fontSize: 16),),
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
                                },
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                  decoration: new BoxDecoration(
                                    color: BaseColor,
                                    borderRadius: BorderRadius.all( Radius.circular(10)),
                                  ),
                                  height: 50,
                                  width: Get.width,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "ادامه سفارش",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'yekan'),
                                      ),
                                      Container(
                                          margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                          child: Icon(Icons.arrow_forward_ios,color: Colors.white,size: 20,)),
                                    ],

                                  ),
                                ))


                        ),

                ],
              ),
            ),
          );
        }),
        bottomNavigationBar: BottomNav(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {Get.offAllNamed("/HomeScreen")},
          child: Icon(Icons.home),
          backgroundColor: BaseColor,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
  Container genItem(CategoryModel category, int position) {
    RxString weight="".obs;
    return Container(

      // splashColor: Colors.white,

      child: Obx(() {
        return Container(
          child: Column(mainAxisSize: MainAxisSize.min, children: [

            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 5, 10),
              alignment: Alignment.centerRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      _formKey.currentState!.save();
                      if(!category.ShowCats.value && !category.CatArr.isEmpty){
                        category.ShowCats.value=true;
                      }
                      else if(category.ShowCats.value){
                        category.ShowCats.value=false;
                        if(basketGlob.containsKey(category.ID)){
                          basketGlob.remove(category.ID);
                        }
                      }
                      else if(!category.ShowCats.value){
                        category.ShowCats.value=true;
                      }


                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        category.CatArr.isEmpty && category.ShowCats.value
                            ?Container(
                            width:150,
                            height: 50,
                            margin: EdgeInsets.fromLTRB(0, 5, 50, 5),
                            child:Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                // controller: TextEditingController(text: weight.value),
                                keyboardType: TextInputType.number,
                                onSaved: (value) {
                                  weight.value=value!;
                                  basketGlob[category.ID]=value;
                                },
                                validator: (value) {
                                  if (value == "") {
                                    return 'وزن وارد نشده است';
                                  }
                                  else {
                                    return null;
                                  }
                                },
                                style:
                                TextStyle(fontSize: 14, color: Colors.black,fontFamily: 'yekan'),
                                textAlign: TextAlign.right,
                                decoration: InputDecoration(
                                  fillColor: GrayColor2,
                                  labelText: "وزن (کیلوگرم)",
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
                                      borderSide: BorderSide(color: Colors.blue)
                                  ),
                                  // prefixIcon: Icon(
                                  //     Icons.wifi_protected_setup_rounded),
                                ),
                              ),
                            ))
                            :Container(),


                        Text(
                          category.Name,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontFamily: 'yekan',color: Colors.black),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 5, 0),
                            decoration: new BoxDecoration(
                              // color:GrayColor,
                              borderRadius:
                              BorderRadius.all( Radius.circular(15)),
                              image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: NetworkImage(Url + "/images/cat/" + category.Pic),
                              ),
                            ),
                            width: 50,
                            height: 50,
                           ),

                        !category.CatArr.isEmpty?
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 15, 0),
                                child: Icon(Icons.add,size: 20,)):
                        Checkbox(
                          value: category.ShowCats.value,
                          onChanged: (value) {

                            category.ShowCats.value=value!;
                            // basketGlob[category.ID] = CatRef;
                            if(value==false){
                              if(basketGlob.containsKey(category.ID)){
                                basketGlob.remove(category.ID);
                              }
                            }
                            // question.checkPdf = true;
                            // questionController.numQues.value=basketGlob.length;
                          },
                        ),

                      ],
                    ),
                  ),
                  category.ShowCats.value && !category.CatArr.isEmpty
                    ? Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for(var item in category.CatArr ) genItemCat(item["ID"], item["Name"], item["Pic"], item["BaseCat"],item["Cat"])
                      ],
                    ),
                  )
                    :Container()
                ],
              ),
            ),
            Divider()

          ]),
        );
      }),
    );
  }
  Container genItemCat(int ID,String Name,String Pic,int BaseCat,int Cat,) {
    // print(catarr);
    RxBool hasCheck=false.obs;
    RxString weight2="".obs;

    return
      Container(
        margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
      child: Obx((){
       return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            hasCheck==true
                ?Container(
              alignment: Alignment.center,
                width:150,
                height: 50,
                margin: EdgeInsets.fromLTRB(0, 5, 50, 5),
                child:Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    // controller: TextEditingController(text: weight2.value),
                    textAlignVertical: TextAlignVertical.center,
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      weight2.value = value!;
                      basketGlob[ID]=value;
                    },
                    validator: (value) {
                      if (value == "") {
                        return 'وزن وارد نشده است';
                      }
                      else {
                        return null;
                      }
                    },
                    style: TextStyle(fontSize: 14, color: Colors.black,fontFamily: 'yekan'),
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      fillColor: GrayColor2,
                      labelText: "وزن (کیلوگرم)",
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
                          borderSide: BorderSide(color: Colors.blue)
                      ),
                      // prefixIcon: Icon(
                      //     Icons.wifi_protected_setup_rounded),
                    ),
                  ),
                ))
                :Container(),
            InkWell(
              onTap: (){
                _formKey.currentState!.save();
                if(hasCheck.value){
                  hasCheck.value=false;
                }
                else if(!hasCheck.value){
                  hasCheck.value=true;
                }

                print("OKKK");
              },
              child: Text(
                Name,
                textDirection: TextDirection.rtl,
                style: TextStyle(fontFamily: 'yekan',color: Colors.black),
              ),
            ),
            Checkbox(
              value: hasCheck.value,
              onChanged: (value) {
                _formKey.currentState!.save();
                hasCheck.value=value!;

                print("OKKK2");
                print(weight2.value.toString()+"PPP");
                // _formKey2.currentState!.save();
                //
                // category.ShowCats.value=value!;
                // basketGlob[category.ID] = CatRef;
                // question.checkPdf = true;
                // questionController.numQues.value=basketGlob.length;
              },
            ),

          ],
        );
      }),
    );
  }

}
