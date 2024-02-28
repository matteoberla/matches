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
      this.points});

  GironiBet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    girone = json['girone'];
    pos1 = json['pos_1'];
    pos2 = json['pos_2'];
    pos3 = json['pos_3'];
    pos4 = json['pos_4'];
    points = json['points'];
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
    return data;
  }
}
