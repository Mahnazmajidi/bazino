import 'package:get/get.dart';

class AddressModel {
  AddressModel(this._ID, this._Address, this._AddressName, this._Lati, this._Longi);
  int _ID=0;
  String _Address="";
  String _AddressName="";
  double _Lati=0;
  double _Longi=0;
  RxBool selected=false.obs;

  int get ID => _ID;
  String get Address => _Address;
  String get AddressName => _AddressName;
  double get Lati => _Lati;
  double get Longi => _Longi;

}