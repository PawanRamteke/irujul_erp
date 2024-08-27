class ProductCategoryModel {
  String? iD;
  String? brand;
  String? productfamily;
  String? capacity;
  String? color;
  String? name;

  ProductCategoryModel(
      {this.iD,
        this.brand,
        this.productfamily,
        this.capacity,
        this.color,
        this.name});

  ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    brand = json['brand'];
    productfamily = json['productfamily'];
    capacity = json['capacity'];
    color = json['color'];
    name = json['Name'];
  }
}
