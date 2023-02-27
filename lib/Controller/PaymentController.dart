import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:bazino/Model/FactorModel.dart';
import 'package:bazino/utils/constants.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class PaymentController extends GetxController {
  RxBool loading = true.obs;
  RxList <FactorModel> factor=<FactorModel>[].obs;
  RxInt geted=0.obs;
  RxInt getedNew=0.obs;
  RxInt orderref=0.obs;
  RxString msg="".obs;
  int paytype=0;
  String address="";
  final LocalStorage storage = new LocalStorage('app');

  onInit() {
    newFactor(this.paytype,this.address);
  }

  PaymentController(int paytype,String address){
      this.address=address;
      this.paytype=paytype;
  }

  newFactor(int paytype,String address) async {
    int UserRef = storage.getItem('UserRef') ?? 0;
    getedNew.value=1;
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      var response = await http.post(Uri.parse(Api),
          body: {'action': 'newFactor', 'key': ApiKey, 'UserRef': UserRef.toString(), 'paytype': paytype.toString(), 'address': address.toString(),'basket': json.encode(basketGlob.toString())});
      if (response.statusCode == 200) {
        print(response.body);
        var jsons = convert.jsonDecode(response.body);
        var ok=jsons["ok"];
        if(ok==1){
          var orderRef=jsons["orderref"];
          orderref.value=orderRef;
          getedNew.value=2;
          basketGlob.clear();
          return orderRef;
        }
        else{
          getedNew.value=3;
          msg.value=jsons["msg"];
          return 0;
        }
      } else {
        getedNew.value=3;
        msg.value="خطا در دریافت اطلاعات";
        return 0;
      }
    }
    else{
      geted.value=4;
      msg.value="اینترنت شما وصل نیست";
    }

  }

}
