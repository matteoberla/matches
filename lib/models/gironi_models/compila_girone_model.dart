class CompilaGironeModel {
  int? teamId;
  int? pos;

  CompilaGironeModel({this.teamId, this.pos});

  CompilaGironeModel.fromJson(Map<String, dynamic> json) {
    teamId = json['team_id'];
    pos = json['pos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['team_id'] = teamId;
    data['pos'] = pos;
    return data;
  }
}
