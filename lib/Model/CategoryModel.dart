import 'package:get/get.dart';

class CategoryModel {

  CategoryModel(this._ID, this._Name, this._Pic, this._BaseCat, this._Cat, this._CatArr);
  int _ID=0;
  String _Name="";
  int _BaseCat=0;
  int _Cat=0;
  String _Pic="";
  List _CatArr=[];
  RxBool ShowCats=false.obs;
  int get ID => _ID;
  int get BaseCat => _BaseCat;
  int get Cat => _Cat;
  String get Name => _Name;
  String get Pic => _Pic;
  List get CatArr => _CatArr;
}