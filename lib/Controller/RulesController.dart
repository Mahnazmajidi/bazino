import 'dart:io';
import 'package:get/get.dart';
import 'package:bazino/utils/constants.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
class RulesController extends GetxController {
  RxInt geted=0.obs;
  RxString msg="".obs;
  RxString content="".obs;
  onInit() {
    getAbout();
  }
  getAbout() async {
    geted.value=1;
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      var response = await http.post(Uri.parse(Api),
          body: {'action': 'getRules', 'key': ApiKey});
      if (response.statusCode == 200) {
        print(response.body);
        var jsons = convert.jsonDecode(response.body);
        var ok=jsons["ok"];
        if(ok==1){
          content.value=jsons["content"];
          geted.value=2;
        }
        else{
          geted.value=3;
          msg.value=jsons["msg"];
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
    }

  }

}
