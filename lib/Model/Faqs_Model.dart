/// error : false
/// message : "Faq Get Sucessfully "
/// data : [{"id":"9","question":"test","answer":"<p>test</p>","status":"1","date_created":"2022-09-08 16:31:05"}]

class FaqsModel {
  FaqsModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  FaqsModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<Data>? _data;
FaqsModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => FaqsModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<Data>? get data => _data;

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

/// id : "9"
/// question : "test"
/// answer : "<p>test</p>"
/// status : "1"
/// date_created : "2022-09-08 16:31:05"

class Data {
  Data({
      String? id, 
      String? question, 
      String? answer, 
      String? status, 
      String? dateCreated,}){
    _id = id;
    _question = question;
    _answer = answer;
    _status = status;
    _dateCreated = dateCreated;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _question = json['question'];
    _answer = json['answer'];
    _status = json['status'];
    _dateCreated = json['date_created'];
  }
  String? _id;
  String? _question;
  String? _answer;
  String? _status;
  String? _dateCreated;
Data copyWith({  String? id,
  String? question,
  String? answer,
  String? status,
  String? dateCreated,
}) => Data(  id: id ?? _id,
  question: question ?? _question,
  answer: answer ?? _answer,
  status: status ?? _status,
  dateCreated: dateCreated ?? _dateCreated,
);
  String? get id => _id;
  String? get question => _question;
  String? get answer => _answer;
  String? get status => _status;
  String? get dateCreated => _dateCreated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['question'] = _question;
    map['answer'] = _answer;
    map['status'] = _status;
    map['date_created'] = _dateCreated;
    return map;
  }

}