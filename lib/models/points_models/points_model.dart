class PointsModel {
  List<Points>? points;

  PointsModel({this.points});

  PointsModel.fromJson(Map<String, dynamic> json) {
    if (json['points'] != null) {
      points = <Points>[];
      json['points'].forEach((v) {
        points!.add(Points.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (points != null) {
      data['points'] = points!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Points {
  int? userId;
  String? username;
  int? isActive;
  String? totalMatchesPoints;
  String? totalGironiPoints;
  String? totalMatchesFinPoints;
  String? totalMatchesFinBonusQuarti;
  String? totalMatchesFinBonusSemi;
  String? totalMatchesFinBonusFinal;
  String? totalMatchesFinBonusTotal;
  String? totalGoalVelocePoints;
  String? totalTeamRivelazPoints;
  String? totalCapoAzzPoints;
  String? totalCapoEuroPoints;
  String? totalPoints;

  Points(
      {this.userId,
      this.username,
      this.isActive,
      this.totalMatchesPoints,
      this.totalGironiPoints,
      this.totalMatchesFinPoints,
      this.totalMatchesFinBonusQuarti,
      this.totalMatchesFinBonusSemi,
      this.totalMatchesFinBonusFinal,
      this.totalMatchesFinBonusTotal,
      this.totalGoalVelocePoints,
      this.totalTeamRivelazPoints,
      this.totalCapoAzzPoints,
      this.totalCapoEuroPoints,
      this.totalPoints});

  Points.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    isActive = json['isActive'];
    totalMatchesPoints = json['total_matches_points'];
    totalGironiPoints = json['total_gironi_points'];
    totalMatchesFinPoints = json['total_matches_fin_points'];
    totalMatchesFinBonusQuarti = json['total_matches_fin_bonus_quarti'];
    totalMatchesFinBonusSemi = json['total_matches_fin_bonus_semi'];
    totalMatchesFinBonusFinal = json['total_matches_fin_bonus_final'];
    totalMatchesFinBonusTotal = json['total_matches_fin_bonus_total'];
    totalGoalVelocePoints = json['total_goal_veloce_points'];
    totalTeamRivelazPoints = json['total_team_rivelaz_points'];
    totalCapoAzzPoints = json['total_capo_azz_points'];
    totalCapoEuroPoints = json['total_capo_euro_points'];
    totalPoints = json['total_points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['username'] = username;
    data['isActive'] = isActive;
    data['total_matches_points'] = totalMatchesPoints;
    data['total_gironi_points'] = totalGironiPoints;
    data['total_matches_fin_points'] = totalMatchesFinPoints;
    data['total_matches_fin_bonus_quarti'] = totalMatchesFinBonusQuarti;
    data['total_matches_fin_bonus_semi'] = totalMatchesFinBonusSemi;
    data['total_matches_fin_bonus_final'] = totalMatchesFinBonusFinal;
    data['total_matches_fin_bonus_total'] = totalMatchesFinBonusTotal;
    data['total_goal_veloce_points'] = totalGoalVelocePoints;
    data['total_team_rivelaz_points'] = totalTeamRivelazPoints;
    data['total_capo_azz_points'] = totalCapoAzzPoints;
    data['total_capo_euro_points'] = totalCapoEuroPoints;
    data['total_points'] = totalPoints;
    return data;
  }
}
