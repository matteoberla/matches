class GoalVeloceBetModel {
  List<GoalVeloceBet>? goalVeloceBet;

  GoalVeloceBetModel({this.goalVeloceBet});

  GoalVeloceBetModel.fromJson(Map<String, dynamic> json) {
    if (json['goal_veloce_bet'] != null) {
      goalVeloceBet = <GoalVeloceBet>[];
      json['goal_veloce_bet'].forEach((v) {
        goalVeloceBet!.add(GoalVeloceBet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (goalVeloceBet != null) {
      data['goal_veloce_bet'] = goalVeloceBet!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GoalVeloceBet {
  int? id;
  int? goalVeloceId;
  int? userId;
  int? idTeam;
  int? points;

  GoalVeloceBet(
      {this.id, this.goalVeloceId, this.userId, this.idTeam, this.points});

  GoalVeloceBet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    goalVeloceId = json['goal_veloce_id'];
    userId = json['user_id'];
    idTeam = json['id_team'];
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['goal_veloce_id'] = goalVeloceId;
    data['user_id'] = userId;
    data['id_team'] = idTeam;
    data['points'] = points;
    return data;
  }
}
