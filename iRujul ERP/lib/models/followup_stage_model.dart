class FollowUpStageModel {
  String? iD;
  String? code;
  String? name;
  String? percentage;
  String? isInitialStage;
  String? isFinalWonStage;
  String? isFinalLossStage;

  FollowUpStageModel(
      {this.iD,
        this.code,
        this.name,
        this.percentage,
        this.isInitialStage,
        this.isFinalWonStage,
        this.isFinalLossStage});

  FollowUpStageModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    code = json['Code'];
    name = json['Name'];
    percentage = json['Percentage'];
    isInitialStage = json['IsInitialStage'];
    isFinalWonStage = json['IsFinalWonStage'];
    isFinalLossStage = json['IsFinalLossStage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = iD;
    data['Code'] = code;
    data['Name'] = name;
    data['Percentage'] = percentage;
    data['IsInitialStage'] = isInitialStage;
    data['IsFinalWonStage'] = isFinalWonStage;
    data['IsFinalLossStage'] = isFinalLossStage;
    return data;
  }
}
