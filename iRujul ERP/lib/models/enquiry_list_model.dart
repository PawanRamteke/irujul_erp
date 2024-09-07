class EnquiryListModel {
  Header? header;
  List<Line>? line;
  List<FollowUpLine>? followUpLine;

  EnquiryListModel({this.header, this.line, this.followUpLine});

  EnquiryListModel.fromJson(Map<String, dynamic> json) {
    header =
    json['Header'] != null ? Header.fromJson(json['Header']) : null;
    if (json['Line'] != null) {
      line = <Line>[];
      json['Line'].forEach((v) {
        line!.add(Line.fromJson(v));
      });
    }
    if (json['FollowUpLine'] != null) {
      followUpLine = <FollowUpLine>[];
      json['FollowUpLine'].forEach((v) {
        followUpLine!.add(FollowUpLine.fromJson(v));
      });
    }
  }
}

class Header {
  String? name;
  String? contactName;
  String? tXNName;
  String? tXNDate;
  String? branchName;
  String? customerName;
  String? customerMobile;
  String? customerEmail;
  String? status;
  String? vendorID;
  String? progressPercentage;
  String? iD;
  Header(
      {this.name,
        this.contactName,
        this.tXNName,
        this.tXNDate,
        this.branchName,
        this.customerName,
        this.customerMobile,
        this.customerEmail,
        this.status,
        this.vendorID,
        this.progressPercentage,
        this.iD
      });

  Header.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    contactName = json['ContactName'];
    tXNName = json['TXNName'];
    tXNDate = json['TXNDate'];
    branchName = json['BranchName'];
    customerName = json['CustomerName'];
    customerMobile = json['CustomerMobile'];
    customerEmail = json['CustomerEmail'];
    status = json['Status'];
    vendorID = json['VendorID'];
    progressPercentage = json['ProgressPercentage'];
    iD = json["ID"];
  }
}

class Line {
  String? tXNID;
  String? itemName;
  String? itemCode;
  String? category;
  String? itemModel;
  String? capacity;
  String? color;
  String? price;
  List<ProductImage>? productImage;

  Line(
      {this.tXNID,
        this.itemName,
        this.itemCode,
        this.category,
        this.itemModel,
        this.capacity,
        this.color,
        this.price,
        this.productImage});

  Line.fromJson(Map<String, dynamic> json) {
    tXNID = json['TXNID'];
    itemName = json['ItemName'];
    itemCode = json['ItemCode'];
    category = json['Category'];
    itemModel = json['ItemModel'];
    capacity = json['Capacity'];
    color = json['Color'];
    price = json['Price'];
    if (json['ProductImage'] != null) {
      productImage = <ProductImage>[];
      json['ProductImage'].forEach((v) {
        productImage!.add(ProductImage.fromJson(v));
      });
    }
  }
}

class ProductImage {
  String? productImagePath;

  ProductImage({this.productImagePath});

  ProductImage.fromJson(Map<String, dynamic> json) {
    productImagePath = json['ProductImagePath'];
  }
}

class FollowUpLine {
  String? followUPLineNo;
  String? visibleToName;
  String? stage;
  String? followUpLeadCategory;
  String? followUpBy;
  String? followUpDate;
  String? followUpTime;
  String? followUpRemark;
  String? nxtFollowUpBy;
  String? nxtFollowUpDate;
  String? nxtFollowUpTime;
  String? progressPercentage;

  FollowUpLine(
      {this.followUPLineNo,
        this.visibleToName,
        this.stage,
        this.followUpLeadCategory,
        this.followUpBy,
        this.followUpDate,
        this.followUpTime,
        this.followUpRemark,
        this.nxtFollowUpBy,
        this.nxtFollowUpDate,
        this.nxtFollowUpTime,
        this.progressPercentage});

  FollowUpLine.fromJson(Map<String, dynamic> json) {
    followUPLineNo = json['FollowUPLineNo'];
    visibleToName = json['VisibleToName'];
    stage = json['Stage'];
    followUpLeadCategory = json['FollowUpLeadCategory'];
    followUpBy = json['FollowUpBy'];
    followUpDate = json['FollowUpDate'];
    followUpTime = json['FollowUpTime'];
    followUpRemark = json['FollowUpRemark'];
    nxtFollowUpBy = json['NxtFollowUpBy'];
    nxtFollowUpDate = json['NxtFollowUpDate'];
    nxtFollowUpTime = json['NxtFollowUpTime'];
    progressPercentage = json['ProgressPercentage'];
  }
}
