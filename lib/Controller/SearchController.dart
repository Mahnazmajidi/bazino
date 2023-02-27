import 'dart:io';

import 'package:get/get.dart';
import 'package:bazino/Model/OrdersModel.dart';
import 'package:bazino/utils/constants.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:localstorage/localstorage.dart';
final LocalStorage storage = new LocalStorage('app');
class SearchController extends GetxController {
  int UserRef = storage.getItem('UserRef') ?? 0;
  RxBool loading = true.obs;
  RxList <OrdersModel> order=<OrdersModel>[].obs;
  RxInt geted=0.obs;
  RxInt getedCancel=0.obs;
  RxString msg="".obs;
  // onInit() {
  //   newRequest();
  // }
  Future<int> newOrder() async {
    geted.value=1;
    bool connect = await InternetConnectionChecker().hasConnection;
    if (connect) {
      int i=0;
      String strBasket="";
      basketGlob.forEach((key, value) {
        if(i>0) strBasket+=",";
        strBasket+='"'+key.toString()+'"'+":"+'"'+value+'"';
        i++;
      });
      print("Username___"+UserName);
      print("Usermobile___"+UserMobile);
      var response = await http.post(Uri.parse(Api),
          body: {'action': 'newOrder', 'key': ApiKey, 'RecycleType': RecycleType.toString(),'UserRef':UserRef.toString(),'basket': {strBasket}.toString(), 'lati': UserLat.toString(), 'longi': UserLong.toString(), 'address': UserAddress, 'name': UserName, 'mobile': UserMobile, 'mobile': UserMobile}).timeout(const Duration(seconds: 4),
        onTimeout: () {
          geted.value=3;
          msg.value="خطا در دریافت اطلاعات";
          // Time has run out, do what you wanted to do.
          return http.Response('Error', 408); // Request Timeout response status code
        },);
      if (response.statusCode == 200) {
        print(response.body);
        var jsons = convert.jsonDecode(response.body);
        var ok=jsons["ok"];
        if(ok==1){
          OrderRef=jsons["orderref"];
          // orderref.value=orderRef;
          geted.value=2;
          return OrderRef;
        }
        else{
          geted.value=3;
          msg.value=jsons["msg"];
          return 0;
        }
      } else {
        geted.value=3;
        msg.value="خطا در دریافت اطلاعات";
        return 0;
      }
    }
    else{
      geted.value=4;
      msg.value="اینترنت شما وصل نیست";
      return 0;
    }

  }
  Future<int> cancel_request_user() async {
    getedCancel.value=1;
    bool connect = await InternetConnectionChecker().hasConnection;
    if (connect) {
      int i=0;
      String strBasket="";
      basketGlob.forEach((key, value) {
        if(i>0) strBasket+=",";
        strBasket+='"'+key.toString()+'"'+":"+'"'+value+'"';
        i++;
      });
      var response = await http.post(Uri.parse(Api),
          body: {'action': 'cancel_request_user', 'key': ApiKey,'UserRef':UserRef.toString(), 'requestRef': OrderRef.toString()}).timeout(const Duration(seconds: 4),
        onTimeout: () {
          geted.value=3;
          Get.offAllNamed("/AddressScreen");
          // Time has run out, do what you wanted to do.
          return http.Response('Error', 408); // Request Timeout response status code
        },);
      if (response.statusCode == 200) {
        print(response.body);
        var jsons = convert.jsonDecode(response.body);
        var ok=jsons["ok"];
        if(ok==1){
          getedCancel.value=2;
          return 1;
        }
        else{
          getedCancel.value=3;
          msg.value=jsons["msg"];
          return 0;
        }
      } else {
        getedCancel.value=3;
        msg.value="خطا در دریافت اطلاعات";
        return 0;
      }
    }
    else{
      getedCancel.value=4;
      msg.value="اینترنت شما وصل نیست";
      return 0;
    }

  }
}
