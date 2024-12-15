import 'package:flutter/material.dart';
import 'package:productos_flutter/src/controller/product_controller.dart';
import 'package:productos_flutter/src/models/product.dart';
import 'package:productos_flutter/src/repository/product_repository.dart';
import 'package:productos_flutter/src/screens/widgets/form_product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeScreen> {
  Product? product;
  @override
  Widget build(BuildContext context) {
    var productController = ProductController(ProductRepository());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products Availables'),
      ),
      body: FutureBuilder<List<Product>>(
        future: productController.fetchProductsList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }
          return builBodyContent(snapshot, productController);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context, builder: (_) => ModalForm(product: product));
        },
      ),
    );
  }

  SafeArea builBodyContent(AsyncSnapshot<List<Product>> snapshot,
      ProductController productController) {
    return SafeArea(
      child: ListView.separated(
          itemBuilder: (context, index) {
            var product = snapshot.data?[index];
            return Container(
              height: 100.0,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(flex: 1, child: Text('${product?.id}')),
                  Expanded(flex: 3, child: Text('${product?.name}')),
                  Expanded(flex: 3, child: Text('${product?.price}')),
                  Expanded(flex: 3, child: Text('${product?.stock}')),
                  Expanded(
                    flex: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => ModalForm(
                                        product: product as Product,
                                      ));
                              //productController.updateProduct(product!);
                            },
                            child: buildCallContainer(Icons.edit,
                                const Color.fromARGB(255, 181, 188, 192))),
                        InkWell(
                            onTap: () {
                              productController
                                  .deleteProduct(product!)
                                  .then((value) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  duration: const Duration(milliseconds: 500),
                                  content: Text(value),
                                ));
                              });
                              setState(() {});
                            },
                            child: buildCallContainer(Icons.delete,
                                const Color.fromARGB(255, 218, 87, 87)))
                      ],
                    ),
                  )
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(thickness: 0.5, height: 0.5);
          },
          itemCount: snapshot.data?.length ?? 0),
    );
  }

  Container buildCallContainer(IconData icon, Color color) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(251, 150, 156, 153),
              offset: Offset(
                5.0,
                5.0,
              ),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ), //BoxShadow
            BoxShadow(
              color: Colors.white,
              offset: Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ), //BoxShadow
          ],
          color: const Color.fromARGB(26, 245, 239, 239),
          borderRadius: BorderRadius.circular(10.0)),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }
}
