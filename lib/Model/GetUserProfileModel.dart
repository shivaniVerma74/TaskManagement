/// error : false
/// message : "Profile Get Sucessfully"
/// data : {"id":"48","first_name":"vishnu","last_name":"Singh","workspace_id":"77","ip_address":"182.77.72.223","username":"VishnuJ","password":"$2y$10$DAZhkxHwpDNi3l3r.UnOCuPMZoV75HZpbm1Hc1my5uJWVtBpQJiQu","email":"vishnu@gmail.com","activation_selector":null,"activation_code":null,"forgotten_password_selector":null,"forgotten_password_code":null,"forgotten_password_time":null,"remember_selector":null,"remember_code":null,"created_on":"1699012553","last_login":"1699013057","active":"1","address":"","city":"","state":"","zip_code":"","country":"","company":null,"logo":null,"half_logo":null,"favicon":null,"phone":"7855999985","alternate_phone":"7452102030","web_fcm":"ex73rZ0aTwSHNuWSPMTqXs:APA91bHirxG1zE2Og5Ip_x5kX8OQFopGsgyNennfwrrXYB5_ijRzCDMa7_r2jJw9Fv_ZijHBHl2h8eY0U7hFZ8RaBeiJILe6mSTAKOl4WPOh4JA0W4XwuQss1bqivg8CcfenaIGDFESX","last_online":"0","lang":"english","chat_theme":"chat-theme-light","profile":null,"email_config":null,"otp":"0","assignee_id":"0","app_status":null,"shift":"Day","dob":null,"blud_group":null,"alternate_number":null}

class GetUserProfileModel {
  GetUserProfileModel({
      bool? error, 
      String? message, 
      Data? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetUserProfileModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _error;
  String? _message;
  Data? _data;
GetUserProfileModel copyWith({  bool? error,
  String? message,
  Data? data,
}) => GetUserProfileModel(  error: error ?? _error,
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

/// id : "48"
/// first_name : "vishnu"
/// last_name : "Singh"
/// workspace_id : "77"
/// ip_address : "182.77.72.223"
/// username : "VishnuJ"
/// password : "$2y$10$DAZhkxHwpDNi3l3r.UnOCuPMZoV75HZpbm1Hc1my5uJWVtBpQJiQu"
/// email : "vishnu@gmail.com"
/// activation_selector : null
/// activation_code : null
/// forgotten_password_selector : null
/// forgotten_password_code : null
/// forgotten_password_time : null
/// remember_selector : null
/// remember_code : null
/// created_on : "1699012553"
/// last_login : "1699013057"
/// active : "1"
/// address : ""
/// city : ""
/// state : ""
/// zip_code : ""
/// country : ""
/// company : null
/// logo : null
/// half_logo : null
/// favicon : null
/// phone : "7855999985"
/// alternate_phone : "7452102030"
/// web_fcm : "ex73rZ0aTwSHNuWSPMTqXs:APA91bHirxG1zE2Og5Ip_x5kX8OQFopGsgyNennfwrrXYB5_ijRzCDMa7_r2jJw9Fv_ZijHBHl2h8eY0U7hFZ8RaBeiJILe6mSTAKOl4WPOh4JA0W4XwuQss1bqivg8CcfenaIGDFESX"
/// last_online : "0"
/// lang : "english"
/// chat_theme : "chat-theme-light"
/// profile : null
/// email_config : null
/// otp : "0"
/// assignee_id : "0"
/// app_status : null
/// shift : "Day"
/// dob : null
/// blud_group : null
/// alternate_number : null

class Data {
  Data({
      String? id, 
      String? firstName, 
      String? lastName, 
      String? workspaceId, 
      String? ipAddress, 
      String? username, 
      String? password, 
      String? email, 
      dynamic activationSelector, 
      dynamic activationCode, 
      dynamic forgottenPasswordSelector, 
      dynamic forgottenPasswordCode, 
      dynamic forgottenPasswordTime, 
      dynamic rememberSelector, 
      dynamic rememberCode, 
      String? createdOn, 
      String? lastLogin, 
      String? active, 
      String? address, 
      String? city, 
      String? state, 
      String? zipCode, 
      String? country, 
      dynamic company, 
      dynamic logo, 
      dynamic halfLogo, 
      dynamic favicon, 
      String? phone, 
      String? alternatePhone, 
      String? webFcm, 
      String? lastOnline, 
      String? lang, 
      String? chatTheme, 
      dynamic profile, 
      dynamic emailConfig, 
      String? otp, 
      String? assigneeId, 
      dynamic appStatus, 
      String? shift, 
      dynamic dob, 
      dynamic bludGroup, 
      dynamic alternateNumber,}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _workspaceId = workspaceId;
    _ipAddress = ipAddress;
    _username = username;
    _password = password;
    _email = email;
    _activationSelector = activationSelector;
    _activationCode = activationCode;
    _forgottenPasswordSelector = forgottenPasswordSelector;
    _forgottenPasswordCode = forgottenPasswordCode;
    _forgottenPasswordTime = forgottenPasswordTime;
    _rememberSelector = rememberSelector;
    _rememberCode = rememberCode;
    _createdOn = createdOn;
    _lastLogin = lastLogin;
    _active = active;
    _address = address;
    _city = city;
    _state = state;
    _zipCode = zipCode;
    _country = country;
    _company = company;
    _logo = logo;
    _halfLogo = halfLogo;
    _favicon = favicon;
    _phone = phone;
    _alternatePhone = alternatePhone;
    _webFcm = webFcm;
    _lastOnline = lastOnline;
    _lang = lang;
    _chatTheme = chatTheme;
    _profile = profile;
    _emailConfig = emailConfig;
    _otp = otp;
    _assigneeId = assigneeId;
    _appStatus = appStatus;
    _shift = shift;
    _dob = dob;
    _bludGroup = bludGroup;
    _alternateNumber = alternateNumber;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _workspaceId = json['workspace_id'];
    _ipAddress = json['ip_address'];
    _username = json['username'];
    _password = json['password'];
    _email = json['email'];
    _activationSelector = json['activation_selector'];
    _activationCode = json['activation_code'];
    _forgottenPasswordSelector = json['forgotten_password_selector'];
    _forgottenPasswordCode = json['forgotten_password_code'];
    _forgottenPasswordTime = json['forgotten_password_time'];
    _rememberSelector = json['remember_selector'];
    _rememberCode = json['remember_code'];
    _createdOn = json['created_on'];
    _lastLogin = json['last_login'];
    _active = json['active'];
    _address = json['address'];
    _city = json['city'];
    _state = json['state'];
    _zipCode = json['zip_code'];
    _country = json['country'];
    _company = json['company'];
    _logo = json['logo'];
    _halfLogo = json['half_logo'];
    _favicon = json['favicon'];
    _phone = json['phone'];
    _alternatePhone = json['alternate_phone'];
    _webFcm = json['web_fcm'];
    _lastOnline = json['last_online'];
    _lang = json['lang'];
    _chatTheme = json['chat_theme'];
    _profile = json['profile'];
    _emailConfig = json['email_config'];
    _otp = json['otp'];
    _assigneeId = json['assignee_id'];
    _appStatus = json['app_status'];
    _shift = json['shift'];
    _dob = json['dob'];
    _bludGroup = json['blud_group'];
    _alternateNumber = json['alternate_number'];
  }
  String? _id;
  String? _firstName;
  String? _lastName;
  String? _workspaceId;
  String? _ipAddress;
  String? _username;
  String? _password;
  String? _email;
  dynamic _activationSelector;
  dynamic _activationCode;
  dynamic _forgottenPasswordSelector;
  dynamic _forgottenPasswordCode;
  dynamic _forgottenPasswordTime;
  dynamic _rememberSelector;
  dynamic _rememberCode;
  String? _createdOn;
  String? _lastLogin;
  String? _active;
  String? _address;
  String? _city;
  String? _state;
  String? _zipCode;
  String? _country;
  dynamic _company;
  dynamic _logo;
  dynamic _halfLogo;
  dynamic _favicon;
  String? _phone;
  String? _alternatePhone;
  String? _webFcm;
  String? _lastOnline;
  String? _lang;
  String? _chatTheme;
  dynamic _profile;
  dynamic _emailConfig;
  String? _otp;
  String? _assigneeId;
  dynamic _appStatus;
  String? _shift;
  dynamic _dob;
  dynamic _bludGroup;
  dynamic _alternateNumber;
Data copyWith({  String? id,
  String? firstName,
  String? lastName,
  String? workspaceId,
  String? ipAddress,
  String? username,
  String? password,
  String? email,
  dynamic activationSelector,
  dynamic activationCode,
  dynamic forgottenPasswordSelector,
  dynamic forgottenPasswordCode,
  dynamic forgottenPasswordTime,
  dynamic rememberSelector,
  dynamic rememberCode,
  String? createdOn,
  String? lastLogin,
  String? active,
  String? address,
  String? city,
  String? state,
  String? zipCode,
  String? country,
  dynamic company,
  dynamic logo,
  dynamic halfLogo,
  dynamic favicon,
  String? phone,
  String? alternatePhone,
  String? webFcm,
  String? lastOnline,
  String? lang,
  String? chatTheme,
  dynamic profile,
  dynamic emailConfig,
  String? otp,
  String? assigneeId,
  dynamic appStatus,
  String? shift,
  dynamic dob,
  dynamic bludGroup,
  dynamic alternateNumber,
}) => Data(  id: id ?? _id,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  workspaceId: workspaceId ?? _workspaceId,
  ipAddress: ipAddress ?? _ipAddress,
  username: username ?? _username,
  password: password ?? _password,
  email: email ?? _email,
  activationSelector: activationSelector ?? _activationSelector,
  activationCode: activationCode ?? _activationCode,
  forgottenPasswordSelector: forgottenPasswordSelector ?? _forgottenPasswordSelector,
  forgottenPasswordCode: forgottenPasswordCode ?? _forgottenPasswordCode,
  forgottenPasswordTime: forgottenPasswordTime ?? _forgottenPasswordTime,
  rememberSelector: rememberSelector ?? _rememberSelector,
  rememberCode: rememberCode ?? _rememberCode,
  createdOn: createdOn ?? _createdOn,
  lastLogin: lastLogin ?? _lastLogin,
  active: active ?? _active,
  address: address ?? _address,
  city: city ?? _city,
  state: state ?? _state,
  zipCode: zipCode ?? _zipCode,
  country: country ?? _country,
  company: company ?? _company,
  logo: logo ?? _logo,
  halfLogo: halfLogo ?? _halfLogo,
  favicon: favicon ?? _favicon,
  phone: phone ?? _phone,
  alternatePhone: alternatePhone ?? _alternatePhone,
  webFcm: webFcm ?? _webFcm,
  lastOnline: lastOnline ?? _lastOnline,
  lang: lang ?? _lang,
  chatTheme: chatTheme ?? _chatTheme,
  profile: profile ?? _profile,
  emailConfig: emailConfig ?? _emailConfig,
  otp: otp ?? _otp,
  assigneeId: assigneeId ?? _assigneeId,
  appStatus: appStatus ?? _appStatus,
  shift: shift ?? _shift,
  dob: dob ?? _dob,
  bludGroup: bludGroup ?? _bludGroup,
  alternateNumber: alternateNumber ?? _alternateNumber,
);
  String? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get workspaceId => _workspaceId;
  String? get ipAddress => _ipAddress;
  String? get username => _username;
  String? get password => _password;
  String? get email => _email;
  dynamic get activationSelector => _activationSelector;
  dynamic get activationCode => _activationCode;
  dynamic get forgottenPasswordSelector => _forgottenPasswordSelector;
  dynamic get forgottenPasswordCode => _forgottenPasswordCode;
  dynamic get forgottenPasswordTime => _forgottenPasswordTime;
  dynamic get rememberSelector => _rememberSelector;
  dynamic get rememberCode => _rememberCode;
  String? get createdOn => _createdOn;
  String? get lastLogin => _lastLogin;
  String? get active => _active;
  String? get address => _address;
  String? get city => _city;
  String? get state => _state;
  String? get zipCode => _zipCode;
  String? get country => _country;
  dynamic get company => _company;
  dynamic get logo => _logo;
  dynamic get halfLogo => _halfLogo;
  dynamic get favicon => _favicon;
  String? get phone => _phone;
  String? get alternatePhone => _alternatePhone;
  String? get webFcm => _webFcm;
  String? get lastOnline => _lastOnline;
  String? get lang => _lang;
  String? get chatTheme => _chatTheme;
  dynamic get profile => _profile;
  dynamic get emailConfig => _emailConfig;
  String? get otp => _otp;
  String? get assigneeId => _assigneeId;
  dynamic get appStatus => _appStatus;
  String? get shift => _shift;
  dynamic get dob => _dob;
  dynamic get bludGroup => _bludGroup;
  dynamic get alternateNumber => _alternateNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['workspace_id'] = _workspaceId;
    map['ip_address'] = _ipAddress;
    map['username'] = _username;
    map['password'] = _password;
    map['email'] = _email;
    map['activation_selector'] = _activationSelector;
    map['activation_code'] = _activationCode;
    map['forgotten_password_selector'] = _forgottenPasswordSelector;
    map['forgotten_password_code'] = _forgottenPasswordCode;
    map['forgotten_password_time'] = _forgottenPasswordTime;
    map['remember_selector'] = _rememberSelector;
    map['remember_code'] = _rememberCode;
    map['created_on'] = _createdOn;
    map['last_login'] = _lastLogin;
    map['active'] = _active;
    map['address'] = _address;
    map['city'] = _city;
    map['state'] = _state;
    map['zip_code'] = _zipCode;
    map['country'] = _country;
    map['company'] = _company;
    map['logo'] = _logo;
    map['half_logo'] = _halfLogo;
    map['favicon'] = _favicon;
    map['phone'] = _phone;
    map['alternate_phone'] = _alternatePhone;
    map['web_fcm'] = _webFcm;
    map['last_online'] = _lastOnline;
    map['lang'] = _lang;
    map['chat_theme'] = _chatTheme;
    map['profile'] = _profile;
    map['email_config'] = _emailConfig;
    map['otp'] = _otp;
    map['assignee_id'] = _assigneeId;
    map['app_status'] = _appStatus;
    map['shift'] = _shift;
    map['dob'] = _dob;
    map['blud_group'] = _bludGroup;
    map['alternate_number'] = _alternateNumber;
    return map;
  }

}