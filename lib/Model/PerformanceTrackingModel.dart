/// error : false
/// message : "Tasks Report!"
/// data : {"total_tasks":"15","completed_task":"7","pending_task":"8"}

class PerformanceTrackingModel{
  PerformanceTrackingModel({
      bool? error, 
      String? message,
    PerformanceData? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  PerformanceTrackingModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'] != null ? PerformanceData.fromJson(json['data']) : null;
  }
  bool? _error;
  String? _message;
  PerformanceData? _data;
PerformanceTrackingModel copyWith({  bool? error,
  String? message,
  PerformanceData? data,
}) => PerformanceTrackingModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  PerformanceData? get data => _data;

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

/// total_tasks : "15"
/// completed_task : "7"
/// pending_task : "8"

class PerformanceData {
  Data({
      String? totalTasks, 
      String? completedTask, 
      String? pendingTask,}){
    _totalTasks = totalTasks;
    _completedTask = completedTask;
    _pendingTask = pendingTask;
}

  PerformanceData.fromJson(dynamic json) {
    _totalTasks = json['total_tasks'];
    _completedTask = json['completed_task'];
    _pendingTask = json['pending_task'];
  }
  String? _totalTasks;
  String? _completedTask;
  String? _pendingTask;
  PerformanceData copyWith({  String? totalTasks,
  String? completedTask,
  String? pendingTask,
}) => Data(  totalTasks: totalTasks ?? _totalTasks,
  completedTask: completedTask ?? _completedTask,
  pendingTask: pendingTask ?? _pendingTask,
);
  String? get totalTasks => _totalTasks;
  String? get completedTask => _completedTask;
  String? get pendingTask => _pendingTask;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_tasks'] = _totalTasks;
    map['completed_task'] = _completedTask;
    map['pending_task'] = _pendingTask;
    return map;
  }

}