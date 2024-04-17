class LoginModel {
  String? token;
  int? id;
  String? name;
  String? email;
  String? password;
  int? admin;
  String? dtScadenza;
  int? appVer;
  String? message;

  LoginModel(
      {this.token,
      this.id,
      this.name,
      this.email,
      this.password,
      this.admin,
      this.dtScadenza,
      this.appVer,
      this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    admin = json['admin'];
    dtScadenza = json['dt_scadenza'];
    appVer = json['app_ver'];
    message = json['message'];
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
    data['app_ver'] = appVer;
    data['message'] = message;
    return data;
  }
}
