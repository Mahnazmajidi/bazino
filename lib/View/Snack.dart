import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Snack extends StatelessWidget {

   void a(){Get.snackbar("..", "..",
       titleText: Text("خطا",textAlign: TextAlign.right,style: TextStyle(color:Colors.white,fontFamily: 'yekan'),),
       messageText: Text("محدودیت تعداد خرید این محصول  عدد می باشد",textAlign: TextAlign.right,style: TextStyle(color:Colors.white,fontFamily: 'yekan',fontSize: 16),),
       backgroundColor:Colors.black,
       icon: Icon(Icons.error,color: Colors.red,textDirection: TextDirection.rtl,),
       duration: Duration(seconds: 3),
       // snackPosition: SnackPosition.BOTTOM,
       overlayColor: Colors.grey.withOpacity(0.5 ),
       dismissDirection: DismissDirection.horizontal,
       overlayBlur: 1,
       colorText: Colors.white);
   }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    a();
    throw UnimplementedError();

  }

}
