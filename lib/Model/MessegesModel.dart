class MessegesModel {

  MessegesModel(this._ID, this._Title, this._Message, this._Date, this._Readed);
  int _ID=0;
  String _Title="";
  String _Message="";
  String _Date="";
  int _Readed=0;

  int get ID => _ID;
  int get Readed => _Readed;
  String get Title => _Title;
  String get Message => _Message;
  String get Date => _Date;
}