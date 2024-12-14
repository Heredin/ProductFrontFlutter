import 'package:productos_flutter/src/models/product.dart';

abstract class Repository {
  Future<List<Product>> getProducts();
  Future<String> updateProduct(Product product);
  Future<String> deleteProduct(Product product);
  Future<String> postProduct(Product product);
}
