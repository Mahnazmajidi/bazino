import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:bazino/Model/FactorModel.dart';
import 'package:bazino/utils/constants.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class FactorController extends GetxController {
  RxBool loading = true.obs;
  RxList <FactorModel> factor=<FactorModel>[].obs;
  RxInt geted=0.obs;
  RxInt getedNew=0.obs;
  RxInt getedDiscount=0.obs;
  RxInt orderref=0.obs;
  RxString msg="".obs;
  RxString link="".obs;
  // onInit() {
  //   getFactor();
  // }
  final LocalStorage storage = new LocalStorage('app');
  getFactor() async {
    factor.clear();
    geted.value=0;
    int i=0;
    String strBasket="";
    basketGlob.forEach((key, value) {
      if(key!="" && value!=""){
        if(i>0) strBasket+=",";
        strBasket+='"'+key.toString()+'"'+":"+'"'+value+'"';
        i++;
      }
    });
    print(DiscountCode.toString());
    var response = await http.post(Uri.parse(Api),
        // body: {'action': 'getFactor', 'key': ApiKey,'basket': json.encode(basketGlob.toString())});
        body: {'action': 'getFactor', 'DiscountCode': DiscountCode, 'key': ApiKey,'basket':{strBasket}.toString() });
    if (response.statusCode == 200) {
      print(response.toString());
      print(response.body.toString());
      var jsons = convert.jsonDecode(response.body);
      var data=jsons["data"];
      var ok=jsons["ok"];
      if(ok==1){
        geted.value=1;
        data.forEach((element) {
          FactorModel cModel=new FactorModel(element["id"],element["name"],element["price"].toString(),element["amount"].toString(),element["sum"].toString());
          factor.add(cModel);
        });
      }
      else{
        geted.value=2;
        msg.value=jsons["msg"];
      }
      // print(data);

      // print(category.length);

    } else {
      geted.value=2;
      msg.value="خطا در دریافت اطلاعات";
    }
    loading.value=false;
  }
  Future<int> checkDiscount(String code) async {
    int UserRef = storage.getItem('UserRef') ?? 0;
    getedDiscount.value=1;
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      var response = await http.post(Uri.parse(Api),
          body: {'action': 'checkDiscount','code': code.toString(),'UserRef':UserRef.toString(), 'key': ApiKey});
      if (response.statusCode == 200) {
        print(response.body);
        var jsons = convert.jsonDecode(response.body);

        var ok=jsons["ok"];
        if(ok==1){
          DiscountCode=jsons["DiscountCode"];
          return 1;
        }
        else{
          msg.value=jsons["msg"];
          DiscountCode="";
          getedDiscount.value=0;
          return 0;
        }
      } else {
        print(response.toString());
        getedDiscount.value=3;
        msg.value="خطا در دریافت اطلاعات...";
        return 0;
      }
    }
    else{
      getedDiscount.value=4;
      msg.value="اینترنت شما وصل نیست";
      return 0;
    }

  }

}
