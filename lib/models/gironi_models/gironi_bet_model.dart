import 'package:flutter/material.dart';

class GironiBetModel {
  List<GironiBet>? gironiBet;

  GironiBetModel({this.gironiBet});

  GironiBetModel.fromJson(Map<String, dynamic> json) {
    if (json['gironi_bet'] != null) {
      gironiBet = <GironiBet>[];
      json['gironi_bet'].forEach((v) {
        gironiBet!.add(GironiBet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (gironiBet != null) {
      data['gironi_bet'] = gironiBet!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GironiBet {
  int? id;
  int? userId;
  String? girone;
  int? pos1;
  int? pos2;
  int? pos3;
  int? pos4;
  int? points;
  String? pt1;
  String? golFatti1;
  String? golSubiti1;
  String? pt2;
  String? golFatti2;
  String? golSubiti2;
  String? pt3;
  String? golFatti3;
  String? golSubiti3;
  String? pt4;
  String? golFatti4;
  String? golSubiti4;

  //
  TextEditingController pos1Controller = TextEditingController();
  TextEditingController pos2Controller = TextEditingController();
  TextEditingController pos3Controller = TextEditingController();
  TextEditingController pos4Controller = TextEditingController();

  GironiBet(
      {this.id,
      this.userId,
      this.girone,
      this.pos1,
      this.pos2,
      this.pos3,
      this.pos4,
      this.points,
      this.pt1,
      this.golFatti1,
      this.golSubiti1,
      this.pt2,
      this.golFatti2,
      this.golSubiti2,
      this.pt3,
      this.golFatti3,
      this.golSubiti3,
      this.pt4,
      this.golFatti4,
      this.golSubiti4});

  GironiBet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    girone = json['girone'];
    pos1 = json['pos_1'];
    pos2 = json['pos_2'];
    pos3 = json['pos_3'];
    pos4 = json['pos_4'];
    points = json['points'];
    pt1 = json['pt_1'];
    golFatti1 = json['gol_fatti_1'];
    golSubiti1 = json['gol_subiti_1'];
    pt2 = json['pt_2'];
    golFatti2 = json['gol_fatti_2'];
    golSubiti2 = json['gol_subiti_2'];
    pt3 = json['pt_3'];
    golFatti3 = json['gol_fatti_3'];
    golSubiti3 = json['gol_subiti_3'];
    pt4 = json['pt_4'];
    golFatti4 = json['gol_fatti_4'];
    golSubiti4 = json['gol_subiti_4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['girone'] = girone;
    data['pos_1'] = pos1;
    data['pos_2'] = pos2;
    data['pos_3'] = pos3;
    data['pos_4'] = pos4;
    data['points'] = points;
    data['pt_1'] = pt1;
    data['gol_fatti_1'] = golFatti1;
    data['gol_subiti_1'] = golSubiti1;
    data['pt_2'] = pt2;
    data['gol_fatti_2'] = golFatti2;
    data['gol_subiti_2'] = golSubiti2;
    data['pt_3'] = pt3;
    data['gol_fatti_3'] = golFatti3;
    data['gol_subiti_3'] = golSubiti3;
    data['pt_4'] = pt4;
    data['gol_fatti_4'] = golFatti4;
    data['gol_subiti_4'] = golSubiti4;
    return data;
  }
}
