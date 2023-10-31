/// error : false
/// message : "Comment Submit Sucessfully"
/// data : {"user_id":"32","task_id":"34","comment":"test"}

class AddCommentModel {
  AddCommentModel({
      bool? error, 
      String? message, 
      Data? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  AddCommentModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _error;
  String? _message;
  Data? _data;
AddCommentModel copyWith({ bool? error,
  String? message,
  Data? data,
}) => AddCommentModel(  error: error ?? _error,
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

/// user_id : "32"
/// task_id : "34"
/// comment : "test"

class Data {
  Data({
      String? userId, 
      String? taskId, 
      String? comment,}){
    _userId = userId;
    _taskId = taskId;
    _comment = comment;
}

  Data.fromJson(dynamic json) {
    _userId = json['user_id'];
    _taskId = json['task_id'];
    _comment = json['comment'];
  }
  String? _userId;
  String? _taskId;
  String? _comment;
Data copyWith({  String? userId,
  String? taskId,
  String? comment,
}) => Data(  userId: userId ?? _userId,
  taskId: taskId ?? _taskId,
  comment: comment ?? _comment,
);
  String? get userId => _userId;
  String? get taskId => _taskId;
  String? get comment => _comment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['task_id'] = _taskId;
    map['comment'] = _comment;
    return map;
  }

}