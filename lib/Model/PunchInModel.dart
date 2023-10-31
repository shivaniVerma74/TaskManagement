/// error : false
/// message : "Welcome !"
/// data : {"user_id":"41","check_in":"08:28:01","date":"2023-10-19","user_status":"OnLeave","punchout_time":"20:28:01"}

class PunchInModel {
  PunchInModel({
      bool? error, 
      String? message,
    PunchInData? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  PunchInModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'] != null ? PunchInData.fromJson(json['data']) : null;
  }
  bool? _error;
  String? _message;
  PunchInData? _data;
PunchInModel copyWith({  bool? error,
  String? message,
  PunchInData? data,
}) => PunchInModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  PunchInData? get data => _data;

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

/// user_id : "41"
/// check_in : "08:28:01"
/// date : "2023-10-19"
/// user_status : "OnLeave"
/// punchout_time : "20:28:01"

class PunchInData {
  PunchInData({
      String? userId, 
      String? checkIn, 
      String? date, 
      String? userStatus, 
      String? punchoutTime,}){
    _userId = userId;
    _checkIn = checkIn;
    _date = date;
    _userStatus = userStatus;
    _punchoutTime = punchoutTime;
}

  PunchInData.fromJson(dynamic json) {
    _userId = json['user_id'];
    _checkIn = json['check_in'];
    _date = json['date'];
    _userStatus = json['user_status'];
    _punchoutTime = json['punchout_time'];
  }
  String? _userId;
  String? _checkIn;
  String? _date;
  String? _userStatus;
  String? _punchoutTime;
  PunchInData copyWith({  String? userId,
  String? checkIn,
  String? date,
  String? userStatus,
  String? punchoutTime,
}) => PunchInData(  userId: userId ?? _userId,
  checkIn: checkIn ?? _checkIn,
  date: date ?? _date,
  userStatus: userStatus ?? _userStatus,
  punchoutTime: punchoutTime ?? _punchoutTime,
);
  String? get userId => _userId;
  String? get checkIn => _checkIn;
  String? get date => _date;
  String? get userStatus => _userStatus;
  String? get punchoutTime => _punchoutTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['check_in'] = _checkIn;
    map['date'] = _date;
    map['user_status'] = _userStatus;
    map['punchout_time'] = _punchoutTime;
    return map;
  }
}