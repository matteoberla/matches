import 'package:flutter/cupertino.dart';

class GironiModel {
  List<Gironi>? gironi;

  GironiModel({this.gironi});

  GironiModel.fromJson(Map<String, dynamic> json) {
    if (json['gironi'] != null) {
      gironi = <Gironi>[];
      json['gironi'].forEach((v) {
        gironi!.add(Gironi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (gironi != null) {
      data['gironi'] = gironi!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Gironi {
  int? id;
  String? girone;
  int? idTeam1;
  int? idTeam2;
  int? idTeam3;
  int? idTeam4;
  int? pos1;
  int? pos2;
  int? pos3;
  int? pos4;

  //
  TextEditingController pos1Controller = TextEditingController();
  TextEditingController pos2Controller = TextEditingController();
  TextEditingController pos3Controller = TextEditingController();
  TextEditingController pos4Controller = TextEditingController();
  TextEditingController gironeController = TextEditingController();

  Gironi(
      {this.id,
      this.girone,
      this.idTeam1,
      this.idTeam2,
      this.idTeam3,
      this.idTeam4,
      this.pos1,
      this.pos2,
      this.pos3,
      this.pos4});

  Gironi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    girone = json['girone'];
    idTeam1 = json['id_team_1'];
    idTeam2 = json['id_team_2'];
    idTeam3 = json['id_team_3'];
    idTeam4 = json['id_team_4'];
    pos1 = json['pos_1'];
    pos2 = json['pos_2'];
    pos3 = json['pos_3'];
    pos4 = json['pos_4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['girone'] = girone;
    data['id_team_1'] = idTeam1;
    data['id_team_2'] = idTeam2;
    data['id_team_3'] = idTeam3;
    data['id_team_4'] = idTeam4;
    data['pos_1'] = pos1;
    data['pos_2'] = pos2;
    data['pos_3'] = pos3;
    data['pos_4'] = pos4;
    return data;
  }
}
