import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazino/OrderDetailScreen.dart';
import 'package:bazino/SplashScreen.dart';
import 'package:bazino/utils/constants.dart';
import 'AboutScreen.dart';
import 'AddressScreen.dart';
import 'MessegesScreen.dart';
import 'CategoryScreen.dart';
import 'DriverinfoScreen.dart';
import 'EditAddressScreen.dart';
import 'FactorScreen.dart';
import 'HomeScreen.dart';
import 'LoginScreen.dart';
import 'NewAddressScreen.dart';
import 'OrdersScreen.dart';
import 'PaymentScreen.dart';
import 'ProfileScreen.dart';
import 'ResultpayScreen.dart';
import 'RulesScreen.dart';
import 'SearchScreen.dart';
import 'SignupScreen.dart';
import 'Test2Screen.dart';
import 'TestScreen.dart';
import 'UserAddressScreen.dart';
// import 'package:firebase_core/firebase_core.dart';
void main() async{
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Bazino",
      initialRoute: "/SplashScreen",
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fadeIn,
      color: BaseColor,
      getPages: [
        GetPage(name: "/SplashScreen", page: ()=>SplashScreen()),
        GetPage(name: "/HomeScreen", page: ()=>HomeScreen()),
        GetPage(name: "/FactorScreen", page: ()=>FactorScreen()),
        GetPage(name: "/PaymentScreen", page: ()=>PaymentScreen()),
        GetPage(name: "/ProfileScreen", page: ()=>ProfileScreen()),
        GetPage(name: "/LoginScreen", page: ()=>LoginScreen()),
        GetPage(name: "/SignupScreen", page: ()=>SignupScreen()),
        GetPage(name: "/OrdersScreen", page: ()=>OrdersScreen()),
        GetPage(name: "/OrderDetailScreen", page: ()=>OrderDetailScreen()),
        GetPage(name: "/ResultpayScreen", page: ()=>ResultpayScreen()),
        GetPage(name: "/AboutScreen", page: ()=>AboutScreen()),
        GetPage(name: "/RulesScreen", page: ()=>RulesScreen()),
        GetPage(name: "/CategoryScreen", page: ()=>CategoryScreen()),
        GetPage(name: "/AddressScreen", page: ()=>AddressScreen()),
        GetPage(name: "/NewAddressScreen", page: ()=>NewAddressScreen()),
        GetPage(name: "/EditAddressScreen", page: ()=>EditAddressScreen()),
        GetPage(name: "/SearchScreen", page: ()=>SearchScreen()),
        GetPage(name: "/DriverinfoScreen", page: ()=>DriverinfoScreen()),
        GetPage(name: "/MessegesScreen", page: ()=>MessegesScreen()),
        GetPage(name: "/UserAddressScreen", page: ()=>UserAddressScreen()),
        GetPage(name: "/TestScreen", page: ()=>getLocation()),
        GetPage(name: "/Test2Screen", page: ()=>Test2()),
      ],
    );
  }
}



