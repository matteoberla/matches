class LoginModel {
  String? token;
  int? id;
  String? name;
  String? email;
  String? password;
  int? admin;
  String? dtScadenza;
  int? appVer;
  int? showPoints;
  String? message;
  bool? impersona;
  String? extraInfo;

  LoginModel(
      {this.token,
      this.id,
      this.name,
      this.email,
      this.password,
      this.admin,
      this.dtScadenza,
      this.showPoints,
      this.appVer,
      this.message,
      this.impersona,
      this.extraInfo});

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    admin = json['admin'];
    dtScadenza = json['dt_scadenza'];
    showPoints = json['show_points'];
    appVer = json['app_ver'];
    message = json['message'];
    impersona = json['impersona'];
    extraInfo = json['extra_info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['admin'] = admin;
    data['dt_scadenza'] = dtScadenza;
    data['show_points'] = showPoints;
    data['app_ver'] = appVer;
    data['message'] = message;
    data['impersona'] = impersona;
    data['extra_info'] = extraInfo;
    return data;
  }
}
