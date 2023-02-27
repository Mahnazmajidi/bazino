import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:get/get.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Location',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: getLocation(),
    );
  }
}

class getLocation extends StatefulWidget {
  @override
  _MyLocationState createState() => _MyLocationState();
}

class _MyLocationState extends State<getLocation> {
  late LocationData _currentPosition;
  late String _address;
  Location location = new Location();
  RxString lat="".obs;
  RxString lan="".obs;
  @override
  void initState() {
    super.initState();
    fetchLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Location"),
      ),
      body: Obx((){
       return Container(
          child: SafeArea(
            child: Column(
              children: [

                Text(
                  "Latitude: ${lat.value}",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),

                Text(
                  "Longitude: ${lan.value}",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),

              ],
            ),
          ),
        );
      }),
    );
  }
  fetchLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    location.onLocationChanged.listen((LocationData currentLocation) {
      lat.value=_currentPosition.latitude.toString();
      lan.value= _currentPosition.longitude.toString();
    });
  }
  Future<String> getAddress(String lat, String lang) async {
    return lat.toString()+lang.toString();
  }

}