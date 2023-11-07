/// error : false
/// message : "Terms Conditions Get Sucessfully "
/// data : [{"id":"5","type":"terms_conditions","data":"<p><strong>Terms and conditions</strong></p>\r\n<section id=\"content\">\r\n<div class=\"container mt-4\">\r\n<p>Terms and Conditions agreements act as a legal contract between you (the company) who has the website or mobile app and the user who access your website and mobile app.</p>\r\n<br>\r\n<p>Having a Terms and Conditions agreement is completely optional. No laws require you to have one. Not even the super-strict and wide-reaching General Data Protection Regulation (<a href=\"https://termsfeed.com/blog/gdpr/\">GDPR</a>).</p>\r\n<br>\r\n<p>It's up to you to set the rules and guidelines that the user must agree to. You can think of your Terms and Conditions agreement as the legal agreement where you <strong>maintain your rights</strong> to exclude users from your app in the event that they abuse your app, where you maintain your legal rights against potential app abusers, and so on.</p>\r\n</div>\r\n</section>","date_created":"2021-06-11 22:24:29"}]

class TermConditionModel {
  TermConditionModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  TermConditionModel.fromJson(dynamic json) {
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
TermConditionModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => TermConditionModel(  error: error ?? _error,
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

/// id : "5"
/// type : "terms_conditions"
/// data : "<p><strong>Terms and conditions</strong></p>\r\n<section id=\"content\">\r\n<div class=\"container mt-4\">\r\n<p>Terms and Conditions agreements act as a legal contract between you (the company) who has the website or mobile app and the user who access your website and mobile app.</p>\r\n<br>\r\n<p>Having a Terms and Conditions agreement is completely optional. No laws require you to have one. Not even the super-strict and wide-reaching General Data Protection Regulation (<a href=\"https://termsfeed.com/blog/gdpr/\">GDPR</a>).</p>\r\n<br>\r\n<p>It's up to you to set the rules and guidelines that the user must agree to. You can think of your Terms and Conditions agreement as the legal agreement where you <strong>maintain your rights</strong> to exclude users from your app in the event that they abuse your app, where you maintain your legal rights against potential app abusers, and so on.</p>\r\n</div>\r\n</section>"
/// date_created : "2021-06-11 22:24:29"

class Data {
  Data({
      String? id, 
      String? type, 
      String? data, 
      String? dateCreated,}){
    _id = id;
    _type = type;
    _data = data;
    _dateCreated = dateCreated;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _data = json['data'];
    _dateCreated = json['date_created'];
  }
  String? _id;
  String? _type;
  String? _data;
  String? _dateCreated;
Data copyWith({  String? id,
  String? type,
  String? data,
  String? dateCreated,
}) => Data(  id: id ?? _id,
  type: type ?? _type,
  data: data ?? _data,
  dateCreated: dateCreated ?? _dateCreated,
);
  String? get id => _id;
  String? get type => _type;
  String? get data => _data;
  String? get dateCreated => _dateCreated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['data'] = _data;
    map['date_created'] = _dateCreated;
    return map;
  }

}