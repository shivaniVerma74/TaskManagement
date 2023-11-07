/// error : false
/// message : "Welcome !"
/// data : {"user_id":"33","check_in":"03:02:39 PM","date":"2023-10-3","user_status":"Compensatory Holiday","shift":null,"punchout_time":"20:28:01","status":"1"}

class PunchInModel {
  PunchInModel({
      bool? error, 
      String? message, 
      Data? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  PunchInModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _error;
  String? _message;
  Data? _data;
PunchInModel copyWith({  bool? error,
  String? message,
  Data? data,
}) => PunchInModel(  error: error ?? _error,
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

/// user_id : "33"
/// check_in : "03:02:39 PM"
/// date : "2023-10-3"
/// user_status : "Compensatory Holiday"
/// shift : null
/// punchout_time : "20:28:01"
/// status : "1"

class Data {
  Data({
      String? userId, 
      String? checkIn, 
      String? date, 
      String? userStatus, 
      dynamic shift, 
      String? punchoutTime, 
      String? status,}){
    _userId = userId;
    _checkIn = checkIn;
    _date = date;
    _userStatus = userStatus;
    _shift = shift;
    _punchoutTime = punchoutTime;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _userId = json['user_id'];
    _checkIn = json['check_in'];
    _date = json['date'];
    _userStatus = json['user_status'];
    _shift = json['shift'];
    _punchoutTime = json['punchout_time'];
    _status = json['status'];
  }
  String? _userId;
  String? _checkIn;
  String? _date;
  String? _userStatus;
  dynamic _shift;
  String? _punchoutTime;
  String? _status;
Data copyWith({  String? userId,
  String? checkIn,
  String? date,
  String? userStatus,
  dynamic shift,
  String? punchoutTime,
  String? status,
}) => Data(  userId: userId ?? _userId,
  checkIn: checkIn ?? _checkIn,
  date: date ?? _date,
  userStatus: userStatus ?? _userStatus,
  shift: shift ?? _shift,
  punchoutTime: punchoutTime ?? _punchoutTime,
  status: status ?? _status,
);
  String? get userId => _userId;
  String? get checkIn => _checkIn;
  String? get date => _date;
  String? get userStatus => _userStatus;
  dynamic get shift => _shift;
  String? get punchoutTime => _punchoutTime;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['check_in'] = _checkIn;
    map['date'] = _date;
    map['user_status'] = _userStatus;
    map['shift'] = _shift;
    map['punchout_time'] = _punchoutTime;
    map['status'] = _status;
    return map;
  }

}