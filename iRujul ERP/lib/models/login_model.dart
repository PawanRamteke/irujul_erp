class LoginModel {
  String? companyID;
  String? branchID;
  String? branchAPIRefCode;
  String? defaultExecutive;
  String? defaultExecutiveCode;
  String? userGroup;
  String? accessToken;
  String? tokenType;
  int? expiresIn;

  LoginModel(
      { this.companyID,
        this.branchID,
        this.branchAPIRefCode,
        this.defaultExecutive,
        this.defaultExecutiveCode,
        this.userGroup,
        this.accessToken,
        this.tokenType,
        this.expiresIn});

  LoginModel.fromJson(Map<String, dynamic> json) {
    companyID = json["CompanyID"];
    branchID = json['BranchID'];
    branchAPIRefCode = json['BranchAPIRefCode'];
    defaultExecutive = json['DefaultExecutive'];
    defaultExecutiveCode = json['DefaultExecutiveCode'];
    userGroup = json['UserGroup'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BranchID'] = this.branchID;
    data['BranchAPIRefCode'] = this.branchAPIRefCode;
    data['DefaultExecutive'] = this.defaultExecutive;
    data['DefaultExecutiveCode'] = this.defaultExecutiveCode;
    data['UserGroup'] = this.userGroup;
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    return data;
  }
}
