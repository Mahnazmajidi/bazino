import 'dart:io';

import 'package:get/get.dart';
import 'package:bazino/Model/OrdersModel.dart';
import 'package:bazino/utils/constants.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:localstorage/localstorage.dart';

import '../Model/MessegesModel.dart';
final LocalStorage storage = new LocalStorage('app');
class MessegesController extends GetxController {
  int UserRef = storage.getItem('UserRef') ?? 0;
  RxBool loading = true.obs;
  RxList <MessegesModel> msges=<MessegesModel>[].obs;
  RxInt geted=0.obs;
  RxString msg="".obs;
  onInit() {
    setMesseges();
  }
  setMesseges() async {
    msges.clear();
    geted.value=1;
    bool connect = await InternetConnectionChecker().hasConnection;
    if (connect) {
      var response = await http.post(Uri.parse(Api),
          body: {'action': 'getMesseges', 'key': ApiKey, 'UserRef': UserRef.toString()}).timeout(const Duration(seconds: 5),
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
        var data=jsons["data"];
        var ok=jsons["ok"];
        if(ok==1){
          geted.value=2;
          if(data==null){
            geted.value=3;
            msg.value="صندوق پیام های شما خالی است";
          }
          else{
            data.forEach((element) {
              MessegesModel cModel=new MessegesModel(element["ID"],element["Title"],element["Message"],element["Date"],element["Readed"]);
              msges.add(cModel);
            });
          }

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
