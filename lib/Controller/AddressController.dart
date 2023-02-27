import 'package:bazino/Model/AddressModel.dart';
import 'package:get/get.dart';
import 'package:bazino/utils/constants.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:localstorage/localstorage.dart';

class AddressController extends GetxController {
  final LocalStorage storage = new LocalStorage('app');
  RxList <AddressModel> address=<AddressModel>[].obs;
  RxInt geted=0.obs;
  RxInt getedNew=0.obs;
  RxString msg="".obs;
  int catref=0;

  onInit() {
    setAddress();
  }

  Future<int> setAddress() async {
    int UserRef = storage.getItem('UserRef') ?? 0;
    geted.value=1;
    bool connect = await InternetConnectionChecker().hasConnection;
    if (connect) {
      var response = await http.post(Uri.parse(Api),
          body: {'action': 'getUserAddress', 'key': ApiKey, 'UserRef': UserRef.toString()}).timeout(const Duration(seconds: 3),
        onTimeout: () {
          geted.value=3;
          msg.value="خطا در دریافت اطلاعات";
          // Time has run out, do what you wanted to do.
          return http.Response('Error', 408); // Request Timeout response status code
        },);

      // var response = await http.get(Uri.parse(Api+"/?action=getCategory")).timeout(const Duration(seconds: 4));
      print(response.toString());
      if (response.statusCode == 200) {
        var jsons = convert.jsonDecode(response.body);
        print(jsons["ok"].toString()+"_________________");
        if(jsons["ok"]==1){
          address.clear();
          var data=jsons["data"];
          if(data!=null){
            data.forEach((element) {
              AddressModel cModel=new AddressModel(element["ID"],element["Address"],element["AddressName"],element["Lati"],element["Longi"]);
              address.add(cModel);
            });
          }

          geted.value=2;
          return 1;
        }
        else{
          geted.value=3;
          msg.value=jsons["msg"];
          return 0;
        }

        // print(category.length);

      } else {
        geted.value=3;
        msg.value="خطا در دریافت اطلاعات";
        print("ERR statusCode: "+response.statusCode.toString());
        return 0;
      }
    }
    else{
      geted.value=4;
      msg.value="اینترنت شما وصل نیست";
      return 0;
    }



  }
  Future<int> newAddress(double lati,double longi,String addressname) async {
    int UserRef = storage.getItem('UserRef') ?? 0;
    getedNew.value=1;
    print(this.catref);
    var response = await http.post(Uri.parse(Api),
        body: {'action': 'newAddress', 'userref': UserRef.toString(), 'lati': lati.toString(), 'longi': longi.toString(), 'address': UserAddress, 'addressname': addressname.toString(), 'user_name': UserName.toString(), 'user_mobile': UserMobile.toString(), 'key': ApiKey}).timeout(const Duration(seconds: 3),
      onTimeout: () {
        getedNew.value=3;
        msg.value="خطا در دریافت اطلاعات";
        // Time has run out, do what you wanted to do.
        return http.Response('Error', 408); // Request Timeout response status code
      },);

    // var response = await http.get(Uri.parse(Api+"/?action=getCategory")).timeout(const Duration(seconds: 4));
    print(response.statusCode.toString());
    print("OKkkk");
    if (response.statusCode == 200) {
      var jsons = convert.jsonDecode(response.body);
      print(jsons["ok"].toString()+"_________________");
      if(jsons["ok"]==1){
        print("OKkkk222");
        getedNew.value=2;
        return 1;
      }
      else{
        getedNew.value=3;
        msg.value=jsons["msg"];
        return 0;
      }
      // print(category.length);

    } else {
      getedNew.value=3;
      msg.value="خطا در دریافت اطلاعات";
      print("ERR statusCode: "+response.statusCode.toString());
      return 0;
    }

  }
  Future<int> editAddress(int addressref,double lati,double longi,String address) async {
    int UserRef = storage.getItem('UserRef') ?? 0;
    geted.value=1;
    print(lati.toString()+"_1");
    print(longi.toString()+"_2");
    print(address.toString()+"_3");
    var response = await http.post(Uri.parse(Api),
        body: {'action': 'editAddress', 'userref': UserRef.toString(), 'addressref': addressref.toString(), 'lati': lati.toString(), 'longi': longi.toString(), 'address': address.toString(), 'key': ApiKey}).timeout(const Duration(seconds: 4));

    // var response = await http.get(Uri.parse(Api+"/?action=getCategory")).timeout(const Duration(seconds: 4));
    print(response.toString());
    if (response.statusCode == 200) {
      var jsons = convert.jsonDecode(response.body);
      print(jsons["ok"].toString()+"_________________");
      if(jsons["ok"]==1){
        geted.value=2;
        return 1;
      }
      else{
        geted.value=3;
        msg.value=jsons["msg"];
        return 0;
      }
      // print(category.length);

    } else {
      geted.value=3;
      msg.value="خطا در دریافت اطلاعات";
      print("ERR statusCode: "+response.statusCode.toString());
      return 0;
    }

  }
  Future<int> deleteAddress(int addressref) async {
    int UserRef = storage.getItem('UserRef') ?? 0;
    geted.value=1;
    print(this.catref);
    var response = await http.post(Uri.parse(Api),
        body: {'action': 'deleteAddress', 'userref': UserRef.toString(), 'addressref': addressref.toString(), 'key': ApiKey}).timeout(const Duration(seconds: 4));

    // var response = await http.get(Uri.parse(Api+"/?action=getCategory")).timeout(const Duration(seconds: 4));
    print(response.toString());
    if (response.statusCode == 200) {
      var jsons = convert.jsonDecode(response.body);
      print(jsons["ok"].toString()+"_________________");
      if(jsons["ok"]==1){
        geted.value=2;
        return 1;
      }
      else{
        geted.value=3;
        msg.value=jsons["msg"];
        return 0;
      }
      // print(category.length);

    } else {
      geted.value=3;
      msg.value="خطا در دریافت اطلاعات";
      print("ERR statusCode: "+response.statusCode.toString());
      return 0;
    }

  }
  Future<int> test() async {
    geted.value=1;
    print(this.catref);
    var response = await http.post(Uri.parse(Api),
        body: {'action': 'deleteAddress'}).timeout(const Duration(seconds: 4));

    // var response = await http.get(Uri.parse(Api+"/?action=getCategory")).timeout(const Duration(seconds: 4));
    print(response.toString());
    if (response.statusCode == 200) {
      var jsons = convert.jsonDecode(response.body);
      print(jsons.toString());
      return 1;
      // print(category.length);

    } else {
      geted.value=3;
      msg.value="خطا در دریافت اطلاعات";
      print("ERR statusCode: "+response.statusCode.toString());
      return 0;
    }

  }
  // ProductController(int cat) {
  //   this.catref=cat;
  //
  // }
}
