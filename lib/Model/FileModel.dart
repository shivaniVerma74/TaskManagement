/// error : false
/// message : "Files Get Sucessfully !"
/// data : [{"id":"6","workspace_id":"52","type_id":"31","user_id":"32","type":"task","original_file_name":"6-17.jpg","file_name":"6-17.jpg","file_extension":"jpg","file_size":"107.7","date_created":"2023-10-30 16:09:22"},{"id":"8","workspace_id":"0","type_id":"31","user_id":"32","type":"task","original_file_name":"6-18.jpg","file_name":"6-18.jpg","file_extension":"jpg","file_size":"107.7","date_created":"2023-10-30 16:09:53"},{"id":"9","workspace_id":"0","type_id":"31","user_id":"32","type":"task","original_file_name":"app_icon.png","file_name":"app_icon.png","file_extension":"png","file_size":"86.53","date_created":"2023-10-30 16:13:23"},{"id":"10","workspace_id":"0","type_id":"31","user_id":"32","type":"task","original_file_name":"app_icon1.png","file_name":"app_icon1.png","file_extension":"png","file_size":"86.53","date_created":"2023-10-30 18:32:08"},{"id":"11","workspace_id":"0","type_id":"31","user_id":"32","type":"task","original_file_name":"app_icon2.png","file_name":"app_icon2.png","file_extension":"png","file_size":"86.53","date_created":"2023-10-31 11:12:43"},{"id":"12","workspace_id":"0","type_id":"31","user_id":"32","type":"task","original_file_name":"app_icon3.png","file_name":"app_icon3.png","file_extension":"png","file_size":"86.53","date_created":"2023-10-31 11:28:27"}]

class FileModel {
  FileModel({
      bool? error, 
      String? message, 
      List<FileData>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  FileModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(FileData.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<FileData>? _data;
FileModel copyWith({  bool? error,
  String? message,
  List<FileData>? data,
}) => FileModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<FileData>? get data => _data;

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

/// id : "6"
/// workspace_id : "52"
/// type_id : "31"
/// user_id : "32"
/// type : "task"
/// original_file_name : "6-17.jpg"
/// file_name : "6-17.jpg"
/// file_extension : "jpg"
/// file_size : "107.7"
/// date_created : "2023-10-30 16:09:22"

class FileData {
  FileData({
      String? id, 
      String? workspaceId, 
      String? typeId, 
      String? userId, 
      String? type, 
      String? originalFileName, 
      String? fileName, 
      String? fileExtension, 
      String? fileSize, 
      String? dateCreated,}){
    _id = id;
    _workspaceId = workspaceId;
    _typeId = typeId;
    _userId = userId;
    _type = type;
    _originalFileName = originalFileName;
    _fileName = fileName;
    _fileExtension = fileExtension;
    _fileSize = fileSize;
    _dateCreated = dateCreated;
}

  FileData.fromJson(dynamic json) {
    _id = json['id'];
    _workspaceId = json['workspace_id'];
    _typeId = json['type_id'];
    _userId = json['user_id'];
    _type = json['type'];
    _originalFileName = json['original_file_name'];
    _fileName = json['file_name'];
    _fileExtension = json['file_extension'];
    _fileSize = json['file_size'];
    _dateCreated = json['date_created'];
  }
  String? _id;
  String? _workspaceId;
  String? _typeId;
  String? _userId;
  String? _type;
  String? _originalFileName;
  String? _fileName;
  String? _fileExtension;
  String? _fileSize;
  String? _dateCreated;
  FileData copyWith({  String? id,
  String? workspaceId,
  String? typeId,
  String? userId,
  String? type,
  String? originalFileName,
  String? fileName,
  String? fileExtension,
  String? fileSize,
  String? dateCreated,
}) => FileData(  id: id ?? _id,
  workspaceId: workspaceId ?? _workspaceId,
  typeId: typeId ?? _typeId,
  userId: userId ?? _userId,
  type: type ?? _type,
  originalFileName: originalFileName ?? _originalFileName,
  fileName: fileName ?? _fileName,
  fileExtension: fileExtension ?? _fileExtension,
  fileSize: fileSize ?? _fileSize,
  dateCreated: dateCreated ?? _dateCreated,
);
  String? get id => _id;
  String? get workspaceId => _workspaceId;
  String? get typeId => _typeId;
  String? get userId => _userId;
  String? get type => _type;
  String? get originalFileName => _originalFileName;
  String? get fileName => _fileName;
  String? get fileExtension => _fileExtension;
  String? get fileSize => _fileSize;
  String? get dateCreated => _dateCreated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['workspace_id'] = _workspaceId;
    map['type_id'] = _typeId;
    map['user_id'] = _userId;
    map['type'] = _type;
    map['original_file_name'] = _originalFileName;
    map['file_name'] = _fileName;
    map['file_extension'] = _fileExtension;
    map['file_size'] = _fileSize;
    map['date_created'] = _dateCreated;
    return map;
  }
}