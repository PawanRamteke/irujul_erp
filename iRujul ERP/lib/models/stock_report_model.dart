class StockReportModel {
  String? branchName;
  String? branchRefCode;
  String? item;
  String? quantity;
  String? mRP;

  StockReportModel(
      {this.branchName,
        this.branchRefCode,
        this.item,
        this.quantity,
        this.mRP});

  StockReportModel.fromJson(Map<String, dynamic> json) {
    branchName = json['BranchName'];
    branchRefCode = json['BranchRefCode'];
    item = json['Item'];
    quantity = json['Quantity'];
    mRP = json['MRP'];
  }
}
