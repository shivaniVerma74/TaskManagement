/// error : true
/// message : "Message Get Successfully!"
/// data : [{"id":"1","user_from":"32","user_to":"2","message":"Hello","read":"0","created_at":"2023-10-27 15:33:57","sender":"Shivani"},{"id":"2","user_from":"2","user_to":"32","message":"Hello From Admin","read":"0","created_at":"2023-10-27 15:33:57","sender":"Kabir."},{"id":"3","user_from":"32","user_to":"2","message":"Hello","read":"0","created_at":"2023-10-27 16:38:57","sender":"Shivani"},{"id":"4","user_from":"32","user_to":"2","message":"hlooo","read":"0","created_at":"2023-10-27 17:13:41","sender":"Shivani"},{"id":"5","user_from":"32","user_to":"2","message":"hlooo","read":"0","created_at":"2023-10-27 17:14:57","sender":"Shivani"},{"id":"6","user_from":"32","user_to":"2","message":"neeee","read":"0","created_at":"2023-10-27 17:18:28","sender":"Shivani"}]

class GetMsgModel {
  GetMsgModel({
      bool? error, 
      String? message, 
      List<GetMsgData>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetMsgModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(GetMsgData.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<GetMsgData>? _data;
GetMsgModel copyWith({  bool? error,
  String? message,
  List<GetMsgData>? data,
}) => GetMsgModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<GetMsgData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// user_from : "32"
/// user_to : "2"
/// message : "Hello"
/// read : "0"
/// created_at : "2023-10-27 15:33:57"
/// sender : "Shivani"

class GetMsgData {
  GetMsgData({
      String? id, 
      String? userFrom, 
      String? userTo, 
      String? message, 
      String? read, 
      String? createdAt, 
      String? sender,}){
    _id = id;
    _userFrom = userFrom;
    _userTo = userTo;
    _message = message;
    _read = read;
    _createdAt = createdAt;
    _sender = sender;
}

  GetMsgData.fromJson(dynamic json) {
    _id = json['id'];
    _userFrom = json['user_from'];
    _userTo = json['user_to'];
    _message = json['message'];
    _read = json['read'];
    _createdAt = json['created_at'];
    _sender = json['sender'];
  }
  String? _id;
  String? _userFrom;
  String? _userTo;
  String? _message;
  String? _read;
  String? _createdAt;
  String? _sender;
  GetMsgData copyWith({  String? id,
  String? userFrom,
  String? userTo,
  String? message,
  String? read,
  String? createdAt,
  String? sender,
}) => GetMsgData(  id: id ?? _id,
  userFrom: userFrom ?? _userFrom,
  userTo: userTo ?? _userTo,
  message: message ?? _message,
  read: read ?? _read,
  createdAt: createdAt ?? _createdAt,
  sender: sender ?? _sender,
);
  String? get id => _id;
  String? get userFrom => _userFrom;
  String? get userTo => _userTo;
  String? get message => _message;
  String? get read => _read;
  String? get createdAt => _createdAt;
  String? get sender => _sender;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_from'] = _userFrom;
    map['user_to'] = _userTo;
    map['message'] = _message;
    map['read'] = _read;
    map['created_at'] = _createdAt;
    map['sender'] = _sender;
    return map;
  }

}