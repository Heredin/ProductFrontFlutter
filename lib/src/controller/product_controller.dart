import 'package:productos_flutter/src/models/product.dart';
import 'package:productos_flutter/src/repository/repository.dart';

class ProductController {
  final Repository _repository;

  ProductController(this._repository);
  Future<List<Product>> fetchProductsList() async {
    return _repository.getProducts();
  }

  Future<String> updateProduct(Product product) async {
    return _repository.updateProduct(product);
  }

  Future<String> deleteProduct(Product product) async {
    return _repository.deleteProduct(product);
  }

  Future<String> postProduct(Product product) async {
    return _repository.postProduct(product);
  }
}
