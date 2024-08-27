class BranchModel {
  String? companyID;
  String? branchID;
  String? branchName;
  String? branchAPIRefCode;

  BranchModel(
      {this.companyID, this.branchID, this.branchName, this.branchAPIRefCode});

  BranchModel.fromJson(Map<String, dynamic> json) {
    companyID = json['CompanyID'];
    branchID = json['BranchID'];
    branchName = json['BranchName'];
    branchAPIRefCode = json['BranchAPIRefCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyID'] = this.companyID;
    data['BranchID'] = this.branchID;
    data['BranchName'] = this.branchName;
    data['BranchAPIRefCode'] = this.branchAPIRefCode;
    return data;
  }
}
