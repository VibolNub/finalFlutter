import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditCategoryScreen extends StatefulWidget {
  final String categoryId;

  EditCategoryScreen({required this.categoryId});

  @override
  _EditCategoryScreenState createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String imageUrl = ''; // Attachment (Image URL)
  bool isLoadingProduct = true;

  @override
  void initState() {
    super.initState();
    fetchCategoryDetails();
  }

  // Fetch category details from the list of categories
  Future<void> fetchCategoryDetails() async {
    final url = 'http://malegend.samrach.pro:8000/categories';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> categories = json.decode(response.body);
        final category = categories.firstWhere(
              (cat) => cat['id'] == widget.categoryId,
          orElse: () => null,
        );

        if (category != null) {
          setState(() {
            name = category['name'];
            imageUrl = category['attachment'];
            isLoadingProduct = false;
          });
        } else {
          throw Exception('Category not found');
        }
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      setState(() => isLoadingProduct = false);
      print(e);
    }
  }

  // Update category details using PUT
  void updateCategory() async {
    final url = 'http://malegend.samrach.pro:8000/categories?id=${widget.categoryId}';
    final body = json.encode({
      "name": name,
      "attachment": imageUrl,
    });

    try {
      final response = await http.put(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'accept': 'application/json'
          },
          body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Category updated successfully!');
        Navigator.pop(context, true); // Return true to indicate success
      } else {
        throw Exception('Failed to update category');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Category'),
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
                initialValue: imageUrl,
                decoration:
                InputDecoration(labelText: 'Attachment (Image URL)'),
                onSaved: (value) => imageUrl = value ?? '',
                validator: (value) =>
                value!.isEmpty ? 'Please enter an image URL' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    updateCategory(); // Call updateCategory when form is valid
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
