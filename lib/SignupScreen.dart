import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazino/utils/constants.dart';
import 'package:bazino/View/BottomNav.dart';
import 'Controller/SignupController.dart';
import 'View/ApppBar.dart';
import 'View/MyDrawer.dart';

class SignupScreen extends StatelessWidget {
  var _formKey = GlobalKey<FormState>();
  var _mobileKey = GlobalKey();
  var _email = "";
  var _identifier_code = "";
  var _fname = "";
  var _lname = "";
  var _mobile = "";
  var _confirm = "";
  String _type = "";

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
    SignupController signupController = Get.put(SignupController());
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

            child: Column(
              children: [
                ApppBar(title: "ثبت نام", back: "/ProfileScreen"),
                Expanded(
                  flex: 1,
                  child:
                        Container(
                          margin: EdgeInsets.fromLTRB(5, 0, 5, 25),
                          // transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                          child: Card(
                            margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20.0))),
                            elevation: 4,
                            child:  Form(
                              key: _formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerRight,
                                      margin: EdgeInsets.fromLTRB(10, 25, 10, 10),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextFormField(

                                          onSaved: (value) {
                                            _fname = value!;
                                          },
                                          validator: (value) {
                                            if (value == null) {
                                              return 'لطفا نام خود را وارد کنید';
                                            }
                                            else if (value.length < 3) {
                                              return 'لطفا یک نام معتبر وارد کنید';
                                            }
                                            else {
                                              return null;
                                            }
                                          },
                                          style:
                                          TextStyle(fontSize: 14, color: Colors.black87,fontFamily: 'yekan'),
                                          textAlign: TextAlign.right,
                                          decoration: InputDecoration(labelText: "نام", labelStyle: TextStyle(fontFamily: 'yekan'),
                                            alignLabelWithHint: true, hintTextDirection: TextDirection.rtl, filled: true, border: OutlineInputBorder(),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide.none,
                                            ),
                                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                                                borderSide: BorderSide(color: Colors.black54)),
                                            prefixIcon: Icon(Icons.person_rounded),
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
                                          onSaved: (value) {
                                            _lname = value!;
                                          },
                                          validator: (value) {
                                            if (value == "") {
                                              return 'لطفا نام خانوادگی خود را وارد کنید';
                                            }
                                            else if (value!.length < 3) {
                                              return 'لطفا یک نام معتبر وارد کنید';
                                            }
                                            else {
                                              return null;
                                            }
                                          },
                                          style:
                                          TextStyle(fontSize: 14, color: Colors.black87,fontFamily: 'yekan'),
                                          textAlign: TextAlign.right,
                                          decoration: InputDecoration(
                                            labelText: "نام خانوادگی",
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
                                            prefixIcon: Icon(
                                                Icons.supervisor_account_sharp),
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
                                          TextStyle(fontSize: 14, color: Colors.black87),
                                          textAlign: TextAlign.right,
                                          decoration: InputDecoration(
                                            labelText: "شماره موبایل",
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
                                                  child: signupController.geted.value == 0
                                                      ? txtbtn(signupController, 1, "دریافت کد تایید")
                                                      : signupController.geted.value == 1
                                                      ? txtbtn(signupController, 2, "در حال ارسال")
                                                      : signupController.geted.value == 2 && signupController.start.value == 0
                                                      ? txtbtn(signupController, 3, "ارسال مجدد")
                                                      : signupController.geted.value == 2
                                                      ? txtbtn(signupController, 4, "ارسال مجدد در\n " + signupController.start.value.toString() + " ثانیه دیگر")
                                                      : txtbtn(signupController, 5, "خطا در ارسال"),
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
                                                      fontSize: 14, color: Colors.black87),
                                                  textAlign: TextAlign.right,
                                                  decoration: InputDecoration(
                                                    labelText: "کد تایید",
                                                    labelStyle: TextStyle(
                                                        fontFamily: 'yekan'),
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
                                                            color: Colors.black54)),
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
                                      alignment: Alignment.centerRight,
                                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextFormField(
                                          keyboardType: TextInputType.emailAddress,
                                          onSaved: (value) {
                                            _identifier_code = value!;
                                          },
                                          style:
                                          TextStyle(fontSize: 14, color: Colors.black87),
                                          textAlign: TextAlign.right,
                                          decoration: InputDecoration(
                                            labelText: "کد معرف (اختیاری)",
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
                                            prefixIcon: Icon(CupertinoIcons.profile_circled),
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
                                          keyboardType: TextInputType.emailAddress,
                                          onSaved: (value) {
                                            _email = value!;
                                          },
                                          style:
                                          TextStyle(fontSize: 14, color: Colors.black87),
                                          textAlign: TextAlign.right,
                                          decoration: InputDecoration(
                                            labelText: "ایمیل (اختیاری)",
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
                                            prefixIcon: Icon(Icons.email),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(10, 30, 10, 50),
                                      child: TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: BaseColor,
                                          ),
                                          onPressed: () {
                                            _formKey.currentState!.validate();
                                            _formKey.currentState!.save();

                                            if (_formKey.currentState!.validate()) {
                                              Future<int> res=signupController.signup(_mobile,_fname,_lname,_email,_confirm,_identifier_code);
                                              res.then((int value) {
                                                if(value==1){
                                                  Get.snackbar("..", "..",
                                                      titleText: Text("موفقیت آمیز", textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontFamily: 'yekan'),),
                                                      messageText: Text("ثبت نام شما با موفقیت انجام شد", textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontFamily: 'yekan', fontSize: 16),),
                                                      backgroundColor: Colors.black,
                                                      icon: Icon(Icons.check_circle, color: Colors.green, textDirection: TextDirection.rtl,),
                                                      duration: Duration(seconds: 5),
                                                      //     snackPosition: SnackPosition.BOTTOM,
                                                      overlayColor: Colors.grey.withOpacity(0.5),
                                                      dismissDirection:
                                                      DismissDirection.horizontal,
                                                      overlayBlur: 1,
                                                      colorText: Colors.white);
                                                  Get.offAllNamed("/HomeScreen");
                                                }
                                                else{
                                                  Get.snackbar("..", "..",
                                                      titleText: Text("خطا",textAlign: TextAlign.right,style: TextStyle(color:Colors.white,fontFamily: 'yekan'),),
                                                      messageText: Text(signupController.signmsg.value,textAlign: TextAlign.right,style: TextStyle(color:Colors.white,fontFamily: 'yekan',fontSize: 16),),
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
                                            child: signupController.getedsignup==1?CircularProgressIndicator(
                                              color: Colors.white,
                                            ):Text(
                                              "ثبت نام",
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

  TextButton txtbtn(SignupController signupController, int type, String title) {

    return TextButton(
        style: TextButton.styleFrom(
          backgroundColor:SecColor,
        ),
        onPressed: () {
          if(type==1 || type==3){

            _formKey.currentState!.save();
            signupController.sendsms(_mobile);
            signupController.startTimer();
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
