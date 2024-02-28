import 'package:flutter/material.dart';

class MatchesModel {
  List<Matches>? matches;

  MatchesModel({this.matches});

  MatchesModel.fromJson(Map<String, dynamic> json) {
    if (json['matches'] != null) {
      matches = <Matches>[];
      json['matches'].forEach((v) {
        matches!.add(Matches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (matches != null) {
      data['matches'] = matches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Matches {
  int? id;
  String? date;
  int? idTeam1;
  int? idTeam2;
  int? fase;
  int? goalTeam1;
  int? goalTeam2;
  int? nMatch;
  String? des1;
  String? des2;
  String? result;

  //
  TextEditingController goal1Controller = TextEditingController();
  TextEditingController goal2Controller = TextEditingController();
  TextEditingController des1Controller = TextEditingController();
  TextEditingController des2Controller = TextEditingController();
  TextEditingController nMatchController = TextEditingController();

  Matches(
      {this.id,
      this.date,
      this.idTeam1,
      this.idTeam2,
      this.fase,
      this.goalTeam1,
      this.goalTeam2,
      this.nMatch,
      this.des1,
      this.des2,
      this.result});

  Matches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    idTeam1 = json['id_team_1'];
    idTeam2 = json['id_team_2'];
    fase = json['fase'];
    goalTeam1 = json['goal_team_1'];
    goalTeam2 = json['goal_team_2'];
    nMatch = json['n_match'];
    des1 = json['des_1'];
    des2 = json['des_2'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['id_team_1'] = idTeam1;
    data['id_team_2'] = idTeam2;
    data['fase'] = fase;
    data['goal_team_1'] = goalTeam1;
    data['goal_team_2'] = goalTeam2;
    data['n_match'] = nMatch;
    data['des_1'] = des1;
    data['des_2'] = des2;
    data['result'] = result;
    return data;
  }
}
