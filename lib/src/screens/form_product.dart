import 'package:flutter/material.dart';
import 'package:productos_flutter/src/controller/product_controller.dart';
import 'package:productos_flutter/src/models/product.dart';
import 'package:productos_flutter/src/repository/product_repository.dart';

class ModalForm extends StatefulWidget {
  final Product? product;
  ModalForm({
    Key? key,
    this.product,
  }) : super(key: key);

  @override
  State<ModalForm> createState() => _ModalFormState();
}

class _ModalFormState extends State<ModalForm> {
  var productController = ProductController(ProductRepository());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = '';
  String _price = '';
  String _stock = '';

  _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (widget.product?.id != null) {
        print('actualizando');
        _formKey.currentState!.save();
        Product product = Product(
            id: widget.product?.id,
            name: _name,
            price: _price.toString(),
            stock: int.parse(_stock));
        productController.updateProduct(product);
      } else {
        _formKey.currentState!.save();
        Product product = Product(
            name: _name, price: _price.toString(), stock: int.parse(_stock));
        productController.postProduct(product);
      }
      setState(() {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(widget.product?.id != null
          ? 'Actualizar Producto'
          : 'Agregar Producto'),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.product?.name,
                decoration: const InputDecoration(
                  labelText: "Nombre",
                  icon: Icon(Icons.account_box),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingresa el nombre';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                  initialValue: widget.product?.price,
                  decoration: const InputDecoration(
                    labelText: "Precio",
                    icon: Icon(Icons.confirmation_number),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingresa el precio';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _price = value!;
                  }),
              TextFormField(
                  initialValue: widget.product?.stock.toString(),
                  decoration: const InputDecoration(
                    labelText: "Stock",
                    icon: Icon(Icons.production_quantity_limits),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingresa el stock';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _stock = value!;
                  }),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          child: Text(widget.product?.id != null ? 'Actualizar' : 'Guardar'),
          onPressed: () {
            _submitForm();
          },
        ),
      ],
    );
  }
}
