import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateProductScreen extends StatefulWidget {
  @override
  _CreateProductScreenState createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  double price = 0.0;
  String description = '';
  String imageUrl = '';
  String? selectedCategoryId;
  Map<String, String> categoryMap = {};
  bool isLoadingCategories = true;

  @override
  void initState() {
    super.initState();
    fetchCategories();
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

  Future<void> addProduct() async {
    final url = 'http://malegend.samrach.pro:8000/products';
    final body = json.encode({
      "name": name,
      "description": description,
      "price": price,
      "attachment": imageUrl,
      "category_id": selectedCategoryId,
    });

    try {
      final response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'}, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Product added successfully!');
        Navigator.pop(context, true); // Pass true to indicate success
      }
      else {
        throw Exception('Failed to add product');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) => name = value ?? '',
                validator: (value) =>
                value!.isEmpty ? 'Please enter a name' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onSaved: (value) => price = double.tryParse(value ?? '') ?? 0.0,
                validator: (value) =>
                value!.isEmpty ? 'Please enter a price' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) => description = value ?? '',
                validator: (value) =>
                value!.isEmpty ? 'Please enter a description' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Image URL'),
                onSaved: (value) => imageUrl = value ?? '',
                validator: (value) =>
                value!.isEmpty ? 'Please enter an image URL' : null,
              ),
              isLoadingCategories
                  ? Center(child: CircularProgressIndicator())
                  : DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Category'),
                items: categoryMap.keys.map((categoryName) {
                  return DropdownMenuItem<String>(
                    value: categoryName,
                    child: Text(categoryName),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategoryId = categoryMap[value];
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
                    addProduct();
                  }
                },
                child: Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
