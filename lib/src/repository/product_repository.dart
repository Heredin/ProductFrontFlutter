import 'dart:convert';

import 'package:productos_flutter/src/models/product.dart';
import 'package:productos_flutter/src/repository/repository.dart';
import 'package:http/http.dart' as http;

class ProductRepository implements Repository {
  String dataURL = 'http://localhost:8000/api';
  @override
  Future<String> deleteProduct(Product product) async {
    var url = Uri.parse('$dataURL/products/${product.id}');
    var result = 'false';
    await http
        .delete(url, headers: {'Accept': 'application/json'}).then((value) {
      print(value.body);
      return result = 'true';
    });
    return result;
  }

  @override
  Future<List<Product>> getProducts() async {
    List<Product> productsList = [];
    var url = Uri.parse('$dataURL/products');
    var response = await http.get(url);
    var body = jsonDecode(response.body);
    for (var i = 0; i < body['data']['products'].length; i++) {
      productsList.add(Product.fromJson(body['data']['products'][i]));
    }
    return productsList;
  }

  @override
  Future<String> postProduct(Product product) async {
    print('${product.toJson()}');
    var url = Uri.parse('$dataURL/products/');
    var result = '';
    var response = await http.post(url, body: product.toJson());
    print(response.statusCode);
    print(response.body);
    return 'true';
  }

  @override
  Future<String> updateProduct(Product product) async {
    var url = Uri.parse('$dataURL/products/${product.id}');
    String resData = '';
    await http.put(url,
        body: product.toJson(),
        headers: {'Accept': 'application/json'}).then((response) {
      Map<String, dynamic> result = json.decode(response.body);
      return resData = result['name'];
    });
    return resData;
  }
}
