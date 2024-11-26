import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:midterm/pages/add.dart';
import 'package:midterm/pages/edit.dart';

class ProductManagementScreen extends StatefulWidget {
  const ProductManagementScreen({Key? key}) : super(key: key);

  @override
  _ProductManagementScreenState createState() => _ProductManagementScreenState();
}

class _ProductManagementScreenState extends State<ProductManagementScreen> {
  final String productUrl = "http://malegend.samrach.pro:8000/products";
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

  void updateProduct(String productId) {
    // Handle update action
    print("Update product with ID: $productId");

    // Navigate to EditProductScreen, passing the productId as an argument
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductScreen(productId: productId), // Passing the productId to the EditProductScreen
      ),
    );
  }


  Future<void> deleteProduct(String productId) async {
    final String deleteUrl = "http://malegend.samrach.pro:8000/products/$productId";

    try {
      final response = await http.delete(Uri.parse(deleteUrl));

      if (response.statusCode == 200) {
        // Product deleted successfully
        print("Product with ID: $productId deleted successfully.");
        fetchProducts(); // Refresh the product list after deletion
      } else {
        // Handle non-200 response
        print("Failed to delete product. Status code: ${response.statusCode}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete product: ${response.statusCode}')),
        );
      }
    } catch (e) {
      // Handle errors
      print("Error deleting product: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred while deleting the product.')),
      );
    }
  }


  void addProduct() {
    // Handle add product action
    print("Add new product");
  }

  Future<void> navigateToCreateProductScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateProductScreen()),
    );

    if (result == true) {
      // Refresh the page
      fetchProducts(); // Call the method to refresh your product list
    }
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
                product['name'],
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
                            Navigator.of(context).pop(); // Close the dialog first
                            deleteProduct(product['id']); // Pass the product ID to the delete function
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
        onPressed: navigateToCreateProductScreen, // Use the method for navigation and refresh
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),

    );
  }
}
