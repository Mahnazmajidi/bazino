import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazino/utils/constants.dart';
import 'package:bazino/View/BottomNav.dart';
import 'package:localstorage/localstorage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Controller/FactorController.dart';
import 'Model/FactorModel.dart';
import 'View/ApppBar.dart';
import 'View/Loading.dart';
import 'View/MyDrawer.dart';

class FactorScreen extends StatelessWidget {
  var _comment = "";
  var _discount = "";
  var _formKey = GlobalKey<FormState>();
  final LocalStorage storage = new LocalStorage('app');
  @override
  Widget build(BuildContext context) {
    FactorController factorController = Get.put(FactorController());
    factorController.getFactor();
    return WillPopScope(
      onWillPop: () async {
        basketGlob.clear();
        Get.offAllNamed("/CategoryScreen");
        return false;
      },
      child: Scaffold(
        endDrawer:MyDrawer(),
        // backgroundColor: Colors.white,
        body: Obx(() {
          return Container(

            child: Column(
              children: [
                ApppBar(title: "جزئیات سفارش", back: "/CategoryScreen"),
                Expanded(
                  flex: 1,
                  child: factorController.geted.value == 0
                      ? Loading()
                      : factorController.geted.value == 2
                          ? Container(child: Text(factorController.msg.value))
                          : Container(
                              margin: EdgeInsets.fromLTRB(5, 0, 5, 35),
                              // transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                              child: Card(
                                margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                elevation: 25,
                                child: ListView.builder(
                                  itemCount: factorController.factor.length,
                                  itemBuilder: (context, position) {
                                    return genItem(factorController.factor[position], position, factorController.factor.length,factorController);
                                  },
                                  padding:
                                      EdgeInsets.fromLTRB(0, 0, 0, 0),
                                ),
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

  Container genItem(FactorModel factor, int position, int lenth,factorController) {
    double TopRadius = 0.0;
    double ButtomRadius = 0;
    var rowColor = Colors.white;
    var textColor = Colors.black;
    if ((position + 1) % 2 == 0) {
      rowColor = BackgroundColor;
    } else {
      rowColor = Colors.white;
    }

    if (position == 0) {
      textColor = Colors.white;
      TopRadius = 15.0;
      rowColor = BaseColor;
    }
    if (position + 1 == lenth) {
      textColor = Colors.white;
      ButtomRadius = 15.0;
      TopRadius = 0.0;
      rowColor = BaseColor;
    }

    return position + 1 == lenth
        ? Container(
            child: Form(
                key: _formKey,
                child: Obx(() {
                  return Column(children: [
                    Container(
                      decoration: BoxDecoration(
                          color: rowColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(TopRadius),
                              topRight: Radius.circular(TopRadius),
                              bottomLeft: Radius.circular(ButtomRadius),
                              bottomRight: Radius.circular(ButtomRadius))),
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Text(factor.Sum,
                                    style: TextStyle(
                                        color: textColor,
                                        fontFamily: "yekan",
                                        fontSize: 14)),
                                // alignment: Alignment.center,
                              ),
                              flex: 4),
                          Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Text(factor.Price,
                                    style: TextStyle(
                                        color: textColor,
                                        fontFamily: "yekan",
                                        fontSize: 14)),
                                // alignment: Alignment.center,
                              ),
                              flex: 4),
                          Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Text(factor.Amount,
                                    style: TextStyle(
                                        color: textColor,
                                        fontFamily: "yekan",
                                        fontSize: 14)),
                                // alignment: Alignment.center,
                              ),
                              flex: 3),
                          Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Text(factor.Name,textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        color: textColor,
                                        fontFamily: "yekan",
                                        fontSize: 14)),
                                // alignment: Alignment.center,
                              ),
                              flex: 4),
                        ],
                      ),
                    ),
                    1==1?Container():Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.fromLTRB(0, 40, 20, 0),
                      child: Text(
                        "نوع پرداخت:",
                        style: TextStyle(
                          fontFamily: "yekan",
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                    1==1?Container():Row(children: [
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.fromLTRB(15, 5, 10, 0),
                        child: InkWell(
                          onTap: () {
                            // payType.value = 2;
                          },
                          child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            // margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                            color: GrayColor2,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            elevation: 6,
                            child: Column(
                              children: [
                                Container(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: Icon(Icons.credit_card)),
                                Container(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                                    child: Text(
                                      "پرداخت آنلاین",
                                      style: TextStyle(fontFamily: "yekan"),
                                    )),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 15, 5),
                                  alignment: Alignment.bottomRight,
                                  width: 1000,
                                  height: 15.0,
                                  child: 1 == 2
                                      ? Container(
                                          alignment: Alignment.bottomRight,
                                          width: 15.0,
                                          height: 15.0,
                                          decoration: new BoxDecoration(
                                            color: Colors.orange,
                                            shape: BoxShape.circle,
                                          ))
                                      : Container(
                                          alignment: Alignment.bottomRight,
                                          width: 15.0,
                                          height: 15.0,
                                        ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.fromLTRB(10, 5, 15, 0),
                        child: InkWell(
                          onTap: () {
                            // payType.value = 1;
                          },
                          child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            // margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                            color: GrayColor2,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            elevation: 6,
                            child: Column(
                              children: [
                                Container(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: Icon(Icons.account_balance_wallet)),
                                Container(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                                    child: Text(
                                      "پرداخت در محل",
                                      style: TextStyle(fontFamily: "yekan"),
                                    )),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 15, 5),
                                  alignment: Alignment.bottomRight,
                                  width: 1000,
                                  height: 15.0,
                                  child: 2 == 1
                                      ? Container(
                                          alignment: Alignment.bottomRight,
                                          width: 15.0,
                                          height: 15.0,
                                          decoration: new BoxDecoration(
                                            color: Colors.orange,
                                            shape: BoxShape.circle,
                                          ))
                                      : Container(
                                          alignment: Alignment.bottomRight,
                                          width: 15.0,
                                          height: 15.0,
                                        ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                    ]),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.fromLTRB(0, 40, 20, 10),
                      child: Text(
                        "توضیحات (در صورت وجود):",
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
                          onSaved: (value) {
                            _comment = value!;
                          },

                          style: TextStyle(fontSize: 14, color: Colors.black,fontFamily: 'yekan'),
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
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.fromLTRB(0, 20, 20, 10),
                      child: Text(
                        "کد تخفیف:",
                        style: TextStyle(
                          fontFamily: "yekan",
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                                flex:2,
                                child:  InkWell(
                                  onTap: (){
                                    _formKey.currentState!.save();
                                    Future<int> res = factorController.checkDiscount(_discount);
                                    res.then(
                                          (int value) {
                                        if (value > 0) {
                                          Get.snackbar("..", "..",
                                              titleText: Text("کد تخفیف با موفقیت اعمال شد", textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontFamily: 'yekan'),),
                                              // messageText: Text("ثبت نام شما با موفقیت انجام شد", textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontFamily: 'yekan', fontSize: 16),),
                                              backgroundColor: Colors.black,
                                              icon: Icon(Icons.check_circle, color: Colors.green, textDirection: TextDirection.rtl,),
                                              duration: Duration(seconds: 4),
                                              //     snackPosition: SnackPosition.BOTTOM,
                                              overlayColor: Colors.grey.withOpacity(0.5),
                                              dismissDirection:
                                              DismissDirection.horizontal,
                                              overlayBlur: 1,
                                              colorText: Colors.white);
                                            Get.offAllNamed("/FactorScreen");
                                        } else {
                                          Get.snackbar("..", "..",
                                              titleText: Text("خطا", textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontFamily: 'yekan'),),
                                              messageText: Text(factorController.msg.value, textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontFamily: 'yekan', fontSize: 16),),
                                              backgroundColor: Colors.black,
                                              icon: Icon(Icons.error, color: Colors.red, textDirection: TextDirection.rtl,),
                                              duration: Duration(seconds: 4),
                                              //     snackPosition: SnackPosition.BOTTOM,
                                              overlayColor: Colors.grey.withOpacity(0.5),
                                              dismissDirection:DismissDirection.horizontal,
                                              overlayBlur: 1,
                                              colorText: Colors.white);
                                        }
                                      },
                                    );
                                  },
                                  child: Container(
                                    // color:BaseColor,
                                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    height: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: BaseColor,
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                    child: factorController.getedDiscount == 1 ? CircularProgressIndicator(color: Colors.white,)
                                        : Text("ثبت", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'yekan'),),
                                  ),
                                )),
                            Expanded(
                              flex:6,
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextFormField(
                                  onSaved: (value) {
                                    _discount = value!;
                                  },

                                  controller: TextEditingController(text: DiscountCode),
                                  style: TextStyle(fontSize: 14, color: Colors.black,fontFamily: 'yekan'),
                                  textAlign: TextAlign.center,
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
                                    prefixIcon: Icon(Icons.price_change),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _formKey.currentState!.validate();
                        _formKey.currentState!.save();
                        Get.offAllNamed("/AddressScreen");
                      },
                      child: Container(
                        // color:BaseColor,
                        margin: EdgeInsets.fromLTRB(25, 40, 25, 45),
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: BaseColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Text("ادامه سفارش", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'yekan'),),
                      ),
                    ),
                  ]);
                })))
        : Container(
            // splashColor: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                  color: rowColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(TopRadius),
                      topRight: Radius.circular(TopRadius),
                      bottomLeft: Radius.circular(ButtomRadius),
                      bottomRight: Radius.circular(ButtomRadius))),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Text(factor.Sum,
                            style: TextStyle(
                                color: textColor,
                                fontFamily: "yekan",
                                fontSize: 14)),
                        // alignment: Alignment.center,
                      ),
                      flex: 4),
                  Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Text(factor.Price,
                            style: TextStyle(
                                color: textColor,
                                fontFamily: "yekan",
                                fontSize: 14)),
                        // alignment: Alignment.center,
                      ),
                      flex: 4),
                  Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Text(factor.Amount,
                            style: TextStyle(
                                color: textColor,
                                fontFamily: "yekan",
                                fontSize: 14)),
                        // alignment: Alignment.center,
                      ),
                      flex: 3),
                  Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Text(factor.Name,
                            style: TextStyle(
                                color: textColor,
                                fontFamily: "yekan",
                                fontSize: 14)),
                        // alignment: Alignment.center,
                      ),
                      flex: 4),
                ],
              ),
            ),
          );
  }
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
