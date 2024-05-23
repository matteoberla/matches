import 'package:flutter/cupertino.dart';

class TeamsModel {
  List<Teams>? teams;

  TeamsModel({this.teams});

  TeamsModel.fromJson(Map<String, dynamic> json) {
    if (json['teams'] != null) {
      teams = <Teams>[];
      json['teams'].forEach((v) {
        teams!.add(Teams.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (teams != null) {
      data['teams'] = teams!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Teams {
  int? id;
  String? name;
  String? iso;
  String? girone;
  String? breve;

  //
  TextEditingController nameController = TextEditingController();
  TextEditingController isoController = TextEditingController();
  TextEditingController gironeController = TextEditingController();

  Teams({this.id, this.name, this.iso, this.girone, this.breve});

  Teams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iso = json['iso'];
    girone = json['girone'];
    breve = json['breve'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['iso'] = iso;
    data['girone'] = girone;
    data['breve'] = breve;
    return data;
  }
}
