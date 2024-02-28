import 'package:flutter/cupertino.dart';

class MatchesBetModel {
  List<MatchesBet>? matchesBet;

  MatchesBetModel({this.matchesBet});

  MatchesBetModel.fromJson(Map<String, dynamic> json) {
    if (json['matches_bet'] != null) {
      matchesBet = <MatchesBet>[];
      json['matches_bet'].forEach((v) {
        matchesBet!.add(MatchesBet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (matchesBet != null) {
      data['matches_bet'] = matchesBet!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MatchesBet {
  int? id;
  int? userId;
  int? matchId;
  int? idTeam1;
  int? idTeam2;
  int? goalTeam1;
  int? goalTeam2;
  String? result;
  int? points;

  //
  TextEditingController goal1Controller = TextEditingController();
  TextEditingController goal2Controller = TextEditingController();

  MatchesBet(
      {this.id,
      this.userId,
      this.matchId,
      this.idTeam1,
      this.idTeam2,
      this.goalTeam1,
      this.goalTeam2,
      this.result,
      this.points});

  MatchesBet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    matchId = json['match_id'];
    idTeam1 = json['id_team_1'];
    idTeam2 = json['id_team_2'];
    goalTeam1 = json['goal_team_1'];
    goalTeam2 = json['goal_team_2'];
    result = json['result'];
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['match_id'] = matchId;
    data['id_team_1'] = idTeam1;
    data['id_team_2'] = idTeam2;
    data['goal_team_1'] = goalTeam1;
    data['goal_team_2'] = goalTeam2;
    data['result'] = result;
    data['points'] = points;
    return data;
  }
}
