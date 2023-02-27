class OrderDetailModel {

  OrderDetailModel(this._ID, this._Name, this._Price, this._Amount, this._Sum);
  int _ID=0;
  String _Name="";
  String _Price="";
  String _Amount="";
  String _Sum="";

  int get ID => _ID;
  String get Name => _Name;
  String get Price => _Price;
  String get Amount => _Amount;
  String get Sum => _Sum;
}