class OrdersModel {

  OrdersModel(this._ID, this._Status, this._Price, this._Driver, this._Date, this._StatusRef);
  int _ID=0;
  int _StatusRef=0;
  String _Status="";
  String _Price="";
  String _Driver="";
  String _Date="";

  int get ID => _ID;
  int get StatusRef => _StatusRef;
  String get Status => _Status;
  String get Price => _Price;
  String get Driver => _Driver;
  String get Date => _Date;
}