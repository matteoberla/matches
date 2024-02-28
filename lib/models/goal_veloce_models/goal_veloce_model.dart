class GoalVeloceModel {
  List<GoalVeloce>? goalVeloce;

  GoalVeloceModel({this.goalVeloce});

  GoalVeloceModel.fromJson(Map<String, dynamic> json) {
    if (json['goal_veloce'] != null) {
      goalVeloce = <GoalVeloce>[];
      json['goal_veloce'].forEach((v) {
        goalVeloce!.add(GoalVeloce.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (goalVeloce != null) {
      data['goal_veloce'] = goalVeloce!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GoalVeloce {
  int? id;
  int? idTeam;

  GoalVeloce({this.id, this.idTeam});

  GoalVeloce.fromJson(Map<String, dynamic> json) {
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
