class TeamRivelazBetModel {
  List<TeamRivelazBet>? teamRivelazBet;

  TeamRivelazBetModel({this.teamRivelazBet});

  TeamRivelazBetModel.fromJson(Map<String, dynamic> json) {
    if (json['team_rivelaz_bet'] != null) {
      teamRivelazBet = <TeamRivelazBet>[];
      json['team_rivelaz_bet'].forEach((v) {
        teamRivelazBet!.add(TeamRivelazBet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (teamRivelazBet != null) {
      data['team_rivelaz_bet'] =
          teamRivelazBet!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeamRivelazBet {
  int? id;
  int? teamRivelazId;
  int? userId;
  int? idTeam;
  int? points;

  TeamRivelazBet(
      {this.id, this.teamRivelazId, this.userId, this.idTeam, this.points});

  TeamRivelazBet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamRivelazId = json['team_rivelaz_id'];
    userId = json['user_id'];
    idTeam = json['id_team'];
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['team_rivelaz_id'] = teamRivelazId;
    data['user_id'] = userId;
    data['id_team'] = idTeam;
    data['points'] = points;
    return data;
  }
}
