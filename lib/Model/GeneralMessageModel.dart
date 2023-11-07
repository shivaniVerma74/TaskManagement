/// error : false
/// message : "Messages Get Succesfully !"
/// data : [{"id":"1","message":"test ","status":"1","users":"32","created_at":"2023-11-02 18:26:14"},{"id":"2","message":"This Is Test Message","status":"0","users":"32","created_at":"2023-11-02 18:26:14"},{"id":"3","message":"This Is Test Message 2","status":"","users":"32","created_at":"2023-11-02 18:31:14"}]

class GeneralMessageModel {
  GeneralMessageModel({
      bool? error, 
      String? message, 
      List<MessageData>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GeneralMessageModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(MessageData.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<MessageData>? _data;
GeneralMessageModel copyWith({  bool? error,
  String? message,
  List<MessageData>? data,
}) => GeneralMessageModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<MessageData>? get data => _data;

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
/// message : "test "
/// status : "1"
/// users : "32"
/// created_at : "2023-11-02 18:26:14"

class MessageData {
  MessageData({
      String? id, 
      String? message, 
      String? status, 
      String? users, 
      String? createdAt,}){
    _id = id;
    _message = message;
    _status = status;
    _users = users;
    _createdAt = createdAt;
}

  MessageData.fromJson(dynamic json) {
    _id = json['id'];
    _message = json['message'];
    _status = json['status'];
    _users = json['users'];
    _createdAt = json['created_at'];
  }
  String? _id;
  String? _message;
  String? _status;
  String? _users;
  String? _createdAt;
  MessageData copyWith({  String? id,
  String? message,
  String? status,
  String? users,
  String? createdAt,
}) => MessageData(  id: id ?? _id,
  message: message ?? _message,
  status: status ?? _status,
  users: users ?? _users,
  createdAt: createdAt ?? _createdAt,
);
  String? get id => _id;
  String? get message => _message;
  String? get status => _status;
  String? get users => _users;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['message'] = _message;
    map['status'] = _status;
    map['users'] = _users;
    map['created_at'] = _createdAt;
    return map;
  }
}