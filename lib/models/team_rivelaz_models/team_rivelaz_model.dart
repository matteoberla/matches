class TeamRivelazModel {
  List<TeamRivelaz>? teamRivelaz;

  TeamRivelazModel({this.teamRivelaz});

  TeamRivelazModel.fromJson(Map<String, dynamic> json) {
    if (json['team_rivelaz'] != null) {
      teamRivelaz = <TeamRivelaz>[];
      json['team_rivelaz'].forEach((v) {
        teamRivelaz!.add(TeamRivelaz.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (teamRivelaz != null) {
      data['team_rivelaz'] = teamRivelaz!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeamRivelaz {
  int? id;
  int? idTeam;

  TeamRivelaz({this.id, this.idTeam});

  TeamRivelaz.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idTeam = json['id_team'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_team'] = idTeam;
    return data;
  }
}
