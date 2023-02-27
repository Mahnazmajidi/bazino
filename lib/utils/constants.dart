import 'dart:collection';
import 'dart:ffi';

import 'package:flutter/material.dart';

const BaseColor = Color(0xff34C76A);
const BackgroundColor = Color(0xffF2F2F2);
const SecColor = Color(0xfffec578);
const ThirdColor = Colors.orangeAccent;
const GrayColor = Color(0xFFB1B1B1);
const GrayColor2 = Color(0xFFEEEEEE);
const BlueColor = Color(0xFF17374E);
const RedColor = Colors.redAccent;
const Api = "https://bazino-app.ir/api10";
const ApiKey = "l1sDfPlq9aLWq0Mz2";
const ApiKeySocket = "l1sSfAlq9aSQq0Mz2";
const Url = "https://bazino-app.ir";
const AppName = "Bazino";
const AppVersion = "100";
HashMap basketGlob = new HashMap<int, String>();
int FirstLaunch=0;
String Token="";

int BaseCatRef=0;
int CatRef=0;
int OrderRef=0;
int AddressRef=0;
int DriverRef=0;
int UserRefHelper=0;

String DriverName = "";
String Drivercar = "";
String DriverPelak = "";
String DriverPelakCity = "";
String DriverImage = "";
String DiscountCode = "";
String DriverMobile = "";
double DriverLat = 0.0;
double DriverLong = 0.0;
String UserName = "";
String UserMobile = "";
String UserAddress = "";
double UserLat = 0.0;
double UserLong = 0.0;
String AdsPic = "";
int RecycleType=0;


