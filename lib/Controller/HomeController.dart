import 'dart:io';
import 'package:get/get.dart';
import 'package:bazino/utils/constants.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:localstorage/localstorage.dart';

import '../Model/MessegesModel.dart';
final LocalStorage storage = new LocalStorage('app');
class HomeController extends GetxController {
  int UserRef = storage.getItem('UserRef') ?? 0;
  RxInt geted=0.obs;
  RxInt unreadMsg=0.obs;
  RxString msg="".obs;
  onInit() {
    homeData();
  }
  homeData() async {
    geted.value=1;
    bool connect = await InternetConnectionChecker().hasConnection;
    if (connect) {
      var response = await http.post(Uri.parse(Api),
          body: {'action': 'homeData', 'key': ApiKey, 'UserRef': UserRef.toString()}).timeout(const Duration(seconds: 5),
        onTimeout: () {
          geted.value=3;
          msg.value="خطا در دریافت اطلاعات";
          // Time has run out, do what you wanted to do.
          return http.Response('Error', 408); // Request Timeout response status code
        },);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        var jsons = convert.jsonDecode(response.body);
        var ok=jsons["ok"];
        if(ok==1){
          geted.value=2;
          unreadMsg.value=jsons["unreadMsg"];
        }
        else{
          geted.value=3;
          msg.value=jsons["msg"];
        }
        // print(data);

        // print(category.length);

      } else {
        geted.value=3;
        msg.value="خطا در دریافت اطلاعات";
      }
    }
    else{
      geted.value=4;
      msg.value="اینترنت شما وصل نیست";
    }


  }
}
