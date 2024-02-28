import 'package:flutter/material.dart';

class CapoAzzBetModel {
  List<CapoAzzBet>? capoAzzBet;

  CapoAzzBetModel({this.capoAzzBet});

  CapoAzzBetModel.fromJson(Map<String, dynamic> json) {
    if (json['capo_azz_bet'] != null) {
      capoAzzBet = <CapoAzzBet>[];
      json['capo_azz_bet'].forEach((v) {
        capoAzzBet!.add(CapoAzzBet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (capoAzzBet != null) {
      data['capo_azz_bet'] = capoAzzBet!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CapoAzzBet {
  int? id;
  int? userId;
  int? betNum;
  String? value;
  int? isValid;
  int? points;

  //
  TextEditingController betController = TextEditingController();

  CapoAzzBet(
      {this.id,
      this.userId,
      this.betNum,
      this.value,
      this.isValid,
      this.points});

  CapoAzzBet.fromJson(Map<String, dynamic> json) {
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
