class LoginModel {
  String? companyID;
  String? companyName;
  String? branchID;
  String? branchAPIRefCode;
  String? branchName;
  String? defaultExecutive;
  String? defaultExecutiveCode;
  String? defaultExecutiveName;
  String? userGroup;
  String? accessToken;
  String? tokenType;
  int? expiresIn;

  LoginModel(
      {this.companyID,
        this.companyName,
        this.branchID,
        this.branchAPIRefCode,
        this.branchName,
        this.defaultExecutive,
        this.defaultExecutiveCode,
        this.defaultExecutiveName,
        this.userGroup,
        this.accessToken,
        this.tokenType,
        this.expiresIn});

  LoginModel.fromJson(Map<String, dynamic> json) {
    companyID = json['CompanyID'];
    companyName = json['CompanyName'];
    branchID = json['BranchID'];
    branchAPIRefCode = json['BranchAPIRefCode'];
    branchName = json['BranchName'];
    defaultExecutive = json['DefaultExecutive'];
    defaultExecutiveCode = json['DefaultExecutiveCode'];
    defaultExecutiveName = json['DefaultExecutiveName'];
    userGroup = json['UserGroup'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CompanyID'] = this.companyID;
    data['CompanyName'] = this.companyName;
    data['BranchID'] = this.branchID;
    data['BranchAPIRefCode'] = this.branchAPIRefCode;
    data['BranchName'] = this.branchName;
    data['DefaultExecutive'] = this.defaultExecutive;
    data['DefaultExecutiveCode'] = this.defaultExecutiveCode;
    data['DefaultExecutiveName'] = this.defaultExecutiveName;
    data['UserGroup'] = this.userGroup;
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    return data;
  }
}
