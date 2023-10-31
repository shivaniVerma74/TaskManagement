/// error : false
/// message : "Marquee Get Sucessfully !"
/// data : {"title":"test","status":"1"}

class GetMarqueeModel {
  GetMarqueeModel({
      bool? error, 
      String? message, 
      Data? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetMarqueeModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _error;
  String? _message;
  Data? _data;
GetMarqueeModel copyWith({  bool? error,
  String? message,
  Data? data,
}) => GetMarqueeModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// title : "test"
/// status : "1"

class Data {
  Data({
      String? title, 
      String? status,}){
    _title = title;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _title = json['title'];
    _status = json['status'];
  }
  String? _title;
  String? _status;
Data copyWith({  String? title,
  String? status,
}) => Data(  title: title ?? _title,
  status: status ?? _status,
);
  String? get title => _title;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['status'] = _status;
    return map;
  }

}