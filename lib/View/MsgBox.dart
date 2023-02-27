import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazino/utils/constants.dart';
import 'package:lottie/lottie.dart';

class MsgBox extends StatelessWidget {
  String title = "";
  String content = "خطا در دریافت اطلاعات";
  String screen = "";
  String img = "notconnect.png";
  int type = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            elevation: 5,
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child:  Image(
                    image: AssetImage('assets/images/'+this.img),
                    height: 200,
                  )
                )
              ,
                this.title != ""
                    ? Container(
                         margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        alignment: Alignment.center,
                        child: Text(
                          this.title,
                          style: TextStyle(fontFamily: "yekan",fontSize: 18,fontWeight: FontWeight.bold ),
                        ))
                    : Container(),
                this.content != ""
                    ? Container(
                        margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        alignment: Alignment.center,
                        child: Text(
                          this.content,
                          style: TextStyle(fontFamily: "yekan",fontSize: 18),
                        ))
                    : Container(),
                InkWell(
                  onTap: (){
                    if(this.screen!=""){
                      Get.offAllNamed(this.screen);
                    }
                  },
                  child:this.screen==""?Container():Container(
                      margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child:
                      Icon(
                        Icons.refresh,
                        size:40 ,
                        color: BaseColor,
                      )
                  )
                ),

              ],
            )));
  }

  MsgBox({String title = "", String content = "", String screen = "", int type = 0, String img = "notconnect.png"}) {
      if(type==1){ // internet not connect
        title="اینترنت شما وصل نیست";
        content="اینترنت خود را وصل و دوباره تلاش کنید";
      }
      this.title=title;
      this.content=content;
      this.screen=screen;
      this.type=type;
      this.img=img;

  }
}
