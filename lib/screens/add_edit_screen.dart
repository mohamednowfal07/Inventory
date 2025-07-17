// ignore_for_file: unused_field, unused_local_variable, dead_code

import 'package:flutter/material.dart';
import 'package:inventory_project/model/product_model.dart';
import 'package:inventory_project/screens/product_listscreen.dart';
import 'package:inventory_project/servives/product_services.dart';

class AddEditScreen extends StatefulWidget {
  final Product? product;
  const AddEditScreen({super.key, this.product});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final productService = FirestoreServices();

  @override
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    bool isEdit = widget.product != null;
    print(isEdit);
    return Scaffold(
      appBar: AppBar(
        title: isEdit ? Text("Edit Product") : Text("Add Product"),
        actions: [
          isEdit
              ? IconButton(
                  onPressed: () {
                    productService
                        .deleteProduct(widget.product!.productId.toString());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductListScreen()));
                  },
                  icon: Icon(Icons.delete),
                )
              : Container(),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Form(
          child: Column(
            children: [
              isEdit
                  ? CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(widget.product!.image),
                      backgroundColor: Colors.grey,
                    )
                  : Container(),
              SizedBox(height: 20),
              TextFormField(
                controller: _idController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("id"),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _idController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Product Name"),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _idController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Product Price"),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  saveProduct();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text(isEdit ? "Product updated" : "Product added"),
                      duration: Duration(seconds: 1),
                    ),
                  );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductListScreen()));
                },
                child: isEdit ? Text("Edit Product ") : Text("Add Product"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveProduct() async {
    if (_formKey.currentState!.validate()) {}

    final product = Product(
      id: _idController.text,
      name: _idController.text,
      image: (widget.product != null)
          ? widget.product!.image
          : "assets/images/jersey.jpg",
      price: double.parse(_priceController.text),
      productId: (widget.product != null) ? widget.product!.productId : 'R',
    );
    if (widget.product == null) {
      await productService.addProduct(product);
    } else {
      await productService.updateProduct(product);
    }
  }
}
