import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazino/utils/constants.dart';
import 'package:localstorage/localstorage.dart';
final LocalStorage storage = new LocalStorage('app');
class BottomNav extends StatelessWidget {

  int isbasket=0;
  @override
  Widget build(BuildContext context) {
    int UserRef = storage.getItem('UserRef') ?? 0;

    return BottomAppBar(
      color: Colors.white ,
      child: Container(
        height: 60,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: InkWell(
                splashColor: Colors.black12,
                onTap: () {
                  if(UserRef==0){
                    Get.offAllNamed("/ProfileScreen",arguments: ["جهت مشاهده ی سفارشات ابتدا وارد حساب کاربری خود شوید"]);
                  }
                  else{
                    Get.offAllNamed("/OrdersScreen");
                  }
                },
                child: Container(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.fact_check_outlined,
                      color: Colors.black87,
                    )),
              ),

            ),
            Expanded(
              child: Container(),
              flex: 1,
            ),



            Expanded(
              flex: 2,
              child: InkWell(
                splashColor: Colors.black12,
                onTap: () {
                  Get.offAllNamed("/ProfileScreen");
                },
                child: Container(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.black87,
                    )),
              ),

            ),

          ],
        ),
      ),
      shape: CircularNotchedRectangle(),
      notchMargin: 8,
      clipBehavior: Clip.antiAlias,
    );
  }

  BottomNav({int IsBasket=0}) {
    this.isbasket=IsBasket;
  }
}
