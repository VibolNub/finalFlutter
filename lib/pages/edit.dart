import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditProductScreen extends StatefulWidget {
  final String productId;

  EditProductScreen({required this.productId});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  double price = 0.0;
  String description = '';
  String imageUrl = '';
  String? selectedCategoryId;
  Map<String, String> categoryMap = {};
  bool isLoadingCategories = true;
  bool isLoadingProduct = true;

  @override
  void initState() {
    super.initState();
    fetchCategories();
    fetchProduct(widget.productId); // Ensure widget.productId is passed as String
  }

  Future<void> fetchCategories() async {
    final String categoryUrl = "http://malegend.samrach.pro:8000/categories";
    try {
      final response = await http.get(Uri.parse(categoryUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;

        setState(() {
          categoryMap = {
            for (var category in data) category['name']: category['id']
          };
          isLoadingCategories = false;
        });
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      setState(() => isLoadingCategories = false);
      print(e);
    }
  }

  Future<void> fetchProduct(String productId) async {
    final String productUrl = "http://malegend.samrach.pro:8000/products/$productId";
    try {
      final response = await http.get(Uri.parse(productUrl));
      if (response.statusCode == 200) {
        final product = json.decode(response.body);

        setState(() {
          name = product['name'];
          price = product['price'].toDouble();
          description = product['description'];
          imageUrl = product['attachment'];
          selectedCategoryId = product['category_id'] ?? ''; // Handle null category_id
          isLoadingProduct = false;
        });
      } else {
        throw Exception('Failed to load product');
      }
    } catch (e) {
      setState(() => isLoadingProduct = false);
      print(e);
    }
  }

  void updateProduct() async {
    final String updateUrl = "http://malegend.samrach.pro:8000/products/${widget.productId}";

    try {
      final response = await http.put(
        Uri.parse(updateUrl),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': name,
          'description': description,
          'price': price,
          'attachment': imageUrl,
          'category_id': selectedCategoryId,
        }),
      );

      if (response.statusCode == 200) {
        // Successfully updated product
        print("Product updated successfully");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product updated successfully')),
        );
        Navigator.pop(context, true); // Return true to indicate the product was updated
      } else {
        // Failed to update product
        print("Failed to update product: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update product: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print("Error updating product: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred while updating the product')),
      );
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoadingProduct
            ? Center(child: CircularProgressIndicator())
            : Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) => name = value ?? '',
                validator: (value) =>
                value!.isEmpty ? 'Please enter a name' : null,
              ),
              TextFormField(
                initialValue: price.toString(),
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onSaved: (value) =>
                price = double.tryParse(value ?? '') ?? 0.0,
                validator: (value) =>
                value!.isEmpty ? 'Please enter a price' : null,
              ),
              TextFormField(
                initialValue: description,
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) => description = value ?? '',
                validator: (value) =>
                value!.isEmpty ? 'Please enter a description' : null,
              ),
              TextFormField(
                initialValue: imageUrl,
                decoration: InputDecoration(labelText: 'Image URL'),
                onSaved: (value) => imageUrl = value ?? '',
                validator: (value) =>
                value!.isEmpty ? 'Please enter an image URL' : null,
              ),
              isLoadingCategories
                  ? Center(child: CircularProgressIndicator())
                  : DropdownButtonFormField<String>(
                value: selectedCategoryId?.isEmpty ?? true
                    ? null
                    : selectedCategoryId, // Handle empty value
                decoration: InputDecoration(labelText: 'Category'),
                items: categoryMap.keys.map((categoryName) {
                  return DropdownMenuItem<String>(
                    value: categoryMap[categoryName],
                    child: Text(categoryName),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategoryId = value;
                  });
                },
                validator: (value) =>
                value == null ? 'Please select a category' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    updateProduct(); // Call update method here
                  }
                },
                child: Text('Accept'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
