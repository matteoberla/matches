import 'package:flutter/cupertino.dart';

class CapoEuroBetModel {
  List<CapoEuroBet>? capoEuroBet;

  CapoEuroBetModel({this.capoEuroBet});

  CapoEuroBetModel.fromJson(Map<String, dynamic> json) {
    if (json['capo_euro_bet'] != null) {
      capoEuroBet = <CapoEuroBet>[];
      json['capo_euro_bet'].forEach((v) {
        capoEuroBet!.add(CapoEuroBet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (capoEuroBet != null) {
      data['capo_euro_bet'] = capoEuroBet!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CapoEuroBet {
  int? id;
  int? userId;
  int? betNum;
  String? value;
  int? isValid;
  int? points;

  //
  TextEditingController betController = TextEditingController();

  CapoEuroBet({
    this.id,
    this.userId,
    this.betNum,
    this.value,
    this.isValid,
    this.points,
  });

  CapoEuroBet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    betNum = json['bet_num'];
    value = json['value'];
    isValid = json['is_valid'];
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['bet_num'] = betNum;
    data['value'] = value;
    data['is_valid'] = isValid;
    data['points'] = points;
    return data;
  }
}
