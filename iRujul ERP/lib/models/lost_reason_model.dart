class LostReasonModel {
  String? value;
  String? text;
  String? code;
  String? description;

  LostReasonModel({this.value, this.text, this.code, this.description});

  LostReasonModel.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
    code = json['code'];
    description = json['Description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;
    data['code'] = code;
    data['Description'] = description;
    return data;
  }
}
