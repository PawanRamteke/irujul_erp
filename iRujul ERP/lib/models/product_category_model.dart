class ProductCategoryModel {
  String? iD;
  String? brand;
  String? productfamily;
  String? capacity;
  String? color;
  String? name;
  String? code;
  ProductCategoryModel(
      {this.iD,
        this.brand,
        this.productfamily,
        this.capacity,
        this.color,
        this.name,
        this.code});

  ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    brand = json['brand'];
    productfamily = json['productfamily'];
    capacity = json['capacity'];
    color = json['color'];
    name = json['Name'];
    code = json['Code'];
  }
}
