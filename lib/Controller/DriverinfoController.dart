import 'dart:async';
import 'dart:io';

import 'package:bazino/Controller/SocketController.dart';
import 'package:get/get.dart';
import 'package:bazino/Model/OrdersModel.dart';
import 'package:bazino/utils/constants.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:localstorage/localstorage.dart';
final LocalStorage storage = new LocalStorage('app');
class DriverinfoController extends GetxController {
  int UserRef = storage.getItem('UserRef') ?? 0;
  RxInt geted=0.obs;
  RxString msg="".obs;
  RxDouble DriverLat=0.0.obs;
  RxDouble DriverLong=0.0.obs;
  late Timer timer;
  SocketController socketController=new SocketController();
  DriverinfoController(SocketController socketController){
    this.socketController=socketController;
  }
  onInit() {

    timer = Timer.periodic(Duration(seconds: 30), (Timer t){
      socketController.socket.emit("update_request",{'OrderRef': OrderRef.toString(),'DriverRef': DriverRef.toString(),'userref': UserRef.toString(), 'key': ApiKeySocket});
    });

  }

  Future<int> newOrder_notuse() async {
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
      var response = await http.post(Uri.parse(Api),
          body: {'action': 'newOrder', 'key': ApiKey,'UserRef':UserRef.toString(),'basket': {strBasket}.toString(), 'addressref': AddressRef.toString()});
      if (response.statusCode == 200) {
        print(response.body);
        var jsons = convert.jsonDecode(response.body);
        var ok=jsons["ok"];
        if(ok==1){
          var orderRef=jsons["orderref"];
          // orderref.value=orderRef;
          geted.value=2;
          return orderRef;
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
}
