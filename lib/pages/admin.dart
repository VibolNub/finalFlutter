import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:midterm/pages/add.dart';

class ProductManagementScreen extends StatefulWidget {
  const ProductManagementScreen({Key? key}) : super(key: key);

  @override
  _ProductManagementScreenState createState() => _ProductManagementScreenState();
}

class _ProductManagementScreenState extends State<ProductManagementScreen> {
  final String productUrl = "https://fakestoreapi.com/products?limit=20";
  List<dynamic>? products;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(productUrl));
      if (response.statusCode == 200) {
        setState(() {
          products = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  void updateProduct(int productId) {
    // Handle update action
    print("Update product with ID: $productId");
  }

  void deleteProduct(int productId) {
    // Handle delete action
    print("Delete product with ID: $productId");
  }

  void addProduct() {
    // Handle add product action
    print("Add new product");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manage Products',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan.shade600,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : products == null
          ? Center(child: Text('Failed to load products'))
          : ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        itemCount: products!.length,
        itemBuilder: (context, index) {
          final product = products![index];
          return Card(
            elevation: 2.0,
            margin: EdgeInsets.symmetric(vertical: 6.0),
            child: ListTile(
              title: Text(
                product['title'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.cyan.shade600),
                    onPressed: () {
                      updateProduct(product['id']);
                    },
                  ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red.shade600),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Confirm Delete"),
                      content: Text("Are you sure you want to delete this product?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            deleteProduct(product['id']); // Call your delete function
                            Navigator.of(context).pop(); // Close the dialog after deletion
                          },
                          child: Text("Delete", style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    );
                  },
                );
              },
            ),


                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan.shade600,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateProductScreen()),
          );
        },
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}
