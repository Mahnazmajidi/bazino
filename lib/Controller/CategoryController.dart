import 'package:get/get.dart';
import 'package:bazino/Model/CategoryModel.dart';
import 'package:bazino/utils/constants.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:localstorage/localstorage.dart';

class CategoryController extends GetxController {
  RxBool loading = true.obs;
  RxList <CategoryModel> product=<CategoryModel>[].obs;
  RxInt geted=0.obs;
  RxString msg="".obs;
  int catref=0;
  final LocalStorage storage = new LocalStorage('app');
  // onInit() {
  //   setProduct();
  // }
  Future<int> setCategory() async {
    int UserRef = storage.getItem('UserRef') ?? 0;
    geted.value=1;
    bool connect = await InternetConnectionChecker().hasConnection;
    if (connect) {
      var response = await http.post(Uri.parse(Api),
          body: {'action': 'getCategory', 'key': ApiKey, 'UserRef': UserRef.toString(), 'token': Token}).timeout(const Duration(seconds: 4),
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
          UserName=jsons["UserName"];
          UserMobile=jsons["UserMobile"];
          AdsPic=jsons["AdsPic"];
          var data=jsons["data"];
          data.forEach((element) {

            var CatArr=[];
            if(element["CatArr"]!=null){
              CatArr=element["CatArr"];
              element["CatArr"].forEach((element2) {
                print(element2["Name"]);
              });

            }
            // else{
            //   CatArr=[];
            // }

            CategoryModel cModel=new CategoryModel(element["ID"],element["Name"],element["Pic"],element["BaseCat"],element["Cat"],CatArr);
            product.add(cModel);
          });
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
      print("BB____");
      geted.value=4;
      msg.value="اینترنت شما وصل نیست";
      return 0;
    }


  }

  // ProductController(int cat) {
  //   this.catref=cat;
  //
  // }
}
