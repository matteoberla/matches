class FasiModel {
  List<Fasi>? fasi;

  FasiModel({this.fasi});

  FasiModel.fromJson(Map<String, dynamic> json) {
    if (json['fasi'] != null) {
      fasi = <Fasi>[];
      json['fasi'].forEach((v) {
        fasi!.add(Fasi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (fasi != null) {
      data['fasi'] = fasi!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Fasi {
  int? id;
  String? fase;

  Fasi({this.id, this.fase});

  Fasi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fase = json['fase'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fase'] = fase;
    return data;
  }
}
