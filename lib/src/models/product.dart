class Product {
  int? id;
  String? name;
  String? price;
  int? stock;

  Product({this.id, this.name, this.price, this.stock});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id.toString();
    data['name'] = this.name;
    data['price'] = this.price.toString();
    data['stock'] = this.stock.toString();
    return data;
  }
}
