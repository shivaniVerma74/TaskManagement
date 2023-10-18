/// error : false
/// message : "Tasks Count Get Sucessfully"
/// data : {"pending_task":"2","complete_tasks":"1","all_tasks":"3"}

class TaskCountModel {
  TaskCountModel({
      bool? error, 
      String? message, 
      Data? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  TaskCountModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _error;
  String? _message;
  Data? _data;
TaskCountModel copyWith({  bool? error,
  String? message,
  Data? data,
}) => TaskCountModel(  error: error ?? _error,
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

/// pending_task : "2"
/// complete_tasks : "1"
/// all_tasks : "3"

class Data {
  Data({
      String? pendingTask, 
      String? completeTasks, 
      String? allTasks,}){
    _pendingTask = pendingTask;
    _completeTasks = completeTasks;
    _allTasks = allTasks;
}

  Data.fromJson(dynamic json) {
    _pendingTask = json['pending_task'];
    _completeTasks = json['complete_tasks'];
    _allTasks = json['all_tasks'];
  }
  String? _pendingTask;
  String? _completeTasks;
  String? _allTasks;
Data copyWith({  String? pendingTask,
  String? completeTasks,
  String? allTasks,
}) => Data(  pendingTask: pendingTask ?? _pendingTask,
  completeTasks: completeTasks ?? _completeTasks,
  allTasks: allTasks ?? _allTasks,
);
  String? get pendingTask => _pendingTask;
  String? get completeTasks => _completeTasks;
  String? get allTasks => _allTasks;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pending_task'] = _pendingTask;
    map['complete_tasks'] = _completeTasks;
    map['all_tasks'] = _allTasks;
    return map;
  }

}