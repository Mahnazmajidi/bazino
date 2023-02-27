import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazino/utils/constants.dart';
import 'package:bazino/View/BottomNav.dart';
import 'Controller/SigninController.dart';
import 'View/ApppBar.dart';
import 'View/MyDrawer.dart';

class LoginScreen extends StatelessWidget {
  var _formKey = GlobalKey<FormState>();
  var _mobileKey = GlobalKey();
  var _mobile = "";
  var _confirm = "";
  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
  @override
  Widget build(BuildContext context) {
    // basketGlob[5] = 2;
    // basketGlob[6] = 3;
    SigninController signinController = Get.put(SigninController());
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed("/ProfileScreen");
        return true;
      },
      child: Scaffold(
        endDrawer:MyDrawer(),
        // backgroundColor: Colors.white,
        body: Obx(() {
          return Container(
            decoration: new BoxDecoration(
              color: Colors.white,
              // borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Column(
              children: [
                ApppBar(title: "ورود", back: "/ProfileScreen"),
                Expanded(
                  flex: 1,
                  child: Container(
                          margin: EdgeInsets.fromLTRB(5, 0, 5, 30),
                          // transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                          child: Card(
                            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20.0))),
                            elevation: 20,
                            child:  Form(
                              key: _formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 40, 0, 60),
                                        child: Image(
                                          image: AssetImage('assets/images/login.png'),
                                          width: 200,
                                          // fit: BoxFit.fill,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: TextFormField(
                                            keyboardType: TextInputType.phone,
                                            key: _mobileKey,
                                            onSaved: (value) {
                                              _mobile = value!;
                                            },
                                            validator: (value) {
                                              if (value == null) {
                                                return 'شماره موبایل خود را وارد کنید';
                                              }
                                              else if (value.length != 11) {
                                                return 'شماره موبایل خود را به صورت 11 رقمی وارد کنید';
                                              }
                                              else if (!isNumeric(value)) {
                                                return 'شماره موبایل معتبر نیست';
                                              }
                                              else {
                                                return null;
                                              }
                                            },
                                            style:
                                            TextStyle(fontSize: 14, color: Colors.black),
                                            textAlign: TextAlign.right,
                                            decoration: InputDecoration(
                                              labelText: "شماره موبایل",
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
                                                  borderRadius: BorderRadius.circular(
                                                      10),
                                                  borderSide: BorderSide(
                                                      color: Colors.black54)),
                                              prefixIcon: Icon(
                                                  Icons.phone_android_outlined),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 4,
                                                  child: Container(

                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 0, 10, 0),
                                                    child: signinController.geted.value == 0
                                                        ? txtbtn(signinController, 1, "دریافت کد تایید")
                                                        : signinController.geted.value == 1
                                                        ? txtbtn(signinController, 2, "در حال ارسال...")
                                                        : signinController.geted.value == 2 && signinController.start.value == 0
                                                        ? txtbtn(signinController, 3, "ارسال مجدد")
                                                        : signinController.geted.value == 2
                                                        ? txtbtn(signinController, 4, "ارسال مجدد در\n " + signinController.start.value.toString() + " ثانیه دیگر")
                                                        : txtbtn(signinController, 1, "دریافت کد تایید"),
                                                  )
                                              ),
                                              Expanded(
                                                flex: 6,
                                                child: Directionality(
                                                  textDirection: TextDirection.rtl,
                                                  child: TextFormField(
                                                    keyboardType: TextInputType.number,
                                                    onSaved: (value) {
                                                      _confirm = value!;
                                                    },
                                                    validator: (value) {
                                                      if (value == null) {
                                                        return 'کد تایید ارسال شده به شماره همراه خود را وارد کنید';
                                                      }
                                                      else if (value.length != 5) {
                                                        return 'کد تایید 5 رقمی را وارد کنید';
                                                      }
                                                      else if (!isNumeric(value)) {
                                                        return 'کد تایید نامعتبر است';
                                                      }
                                                      else {
                                                        return null;
                                                      }
                                                    },
                                                    style:
                                                    TextStyle(
                                                        fontSize: 14, color: Colors.black),
                                                    textAlign: TextAlign.right,
                                                    decoration: InputDecoration(
                                                      labelText: "کد تایید",
                                                      labelStyle: TextStyle(fontFamily: 'yekan'),
                                                      alignLabelWithHint: true,
                                                      hintTextDirection: TextDirection
                                                          .rtl,
                                                      filled: true,
                                                      border: OutlineInputBorder(),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .circular(10),
                                                        borderSide: BorderSide.none,
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius
                                                              .circular(10),
                                                          borderSide: BorderSide(
                                                              color: BaseColor)),
                                                      prefixIcon: Icon(
                                                          Icons.eighteen_mp),
                                                    ),
                                                  ),
                                                ),
                                              ),

                                            ]
                                        ),
                                      ),

                                      Container(
                                        margin: EdgeInsets.fromLTRB(10, 30, 10, 50),
                                        child: TextButton(
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(BaseColor),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(15.0),
                                                      // side: BorderSide(color: Colors.red)
                                                  )
                                              )
                                          ),
                                            onPressed: () {
                                              _formKey.currentState!.validate();
                                              _formKey.currentState!.save();
                                              if (_formKey.currentState!.validate()) {

                                                Future<int> res=signinController.signin(_mobile,_confirm);
                                                res.then((int value) {
                                                  if(value==1){

                                                    Get.offAllNamed("/CategoryScreen");
                                                  }
                                                  else{
                                                    Get.snackbar("..", "..",
                                                        titleText: Text("خطا",textAlign: TextAlign.right,style: TextStyle(color:Colors.white,fontFamily: 'yekan'),),
                                                        messageText: Text(signinController.signmsg.value,textAlign: TextAlign.right,style: TextStyle(color:Colors.white,fontFamily: 'yekan',fontSize: 16),),
                                                        backgroundColor:Colors.black,
                                                        icon: Icon(Icons.error,color: Colors.red,textDirection: TextDirection.rtl,),
                                                        duration: Duration(seconds: 3),
                                                        //     snackPosition: SnackPosition.BOTTOM,
                                                        overlayColor: Colors.grey.withOpacity(0.5 ),
                                                        dismissDirection: DismissDirection.horizontal,
                                                        overlayBlur: 1,
                                                        colorText: Colors.white);
                                                  }
                                                },
                                                );




                                              }
                                              else {
                                                print("NO");
                                              }
                                            },
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                              height: 35,
                                              alignment: Alignment.center,
                                              child: signinController.getedsignup==1?CircularProgressIndicator(
                                                color: Colors.white,
                                              ):Text(
                                                "ورود",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'yekan'),
                                              ),
                                            )),
                                      )
                                    ]
                                ),
                              ),
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

  TextButton txtbtn(SigninController signinController, int type, String title) {

    return TextButton(
        style: TextButton.styleFrom(
          backgroundColor:SecColor,
        ),
        onPressed: () {
          if(type==1 || type==3){

            _formKey.currentState!.save();
            signinController.sendsms(_mobile);
            signinController.startTimer();
          }

        },
        child: Container(
          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
          height: 40,
          alignment: Alignment.center,

          child: Text(
            title,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'yekan'),
          ),
        ));
  }
}
