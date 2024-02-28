class SelectionListItemModel {
  String? key;
  String? keyInfo1;
  String? keyInfo2;
  String? value;
  String? description;

  SelectionListItemModel(
      {this.key, this.keyInfo1, this.keyInfo2, this.value, this.description});

  SelectionListItemModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    keyInfo1 = json['keyInfo1'];
    keyInfo2 = json['keyInfo2'];
    value = json['value'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['keyInfo1'] = keyInfo1;
    data['keyInfo2'] = keyInfo2;
    data['value'] = value;
    data['description'] = description;
    return data;
  }
}
