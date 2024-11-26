import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateCategoryScreen extends StatefulWidget {
  @override
  _CreateCategoryScreenState createState() => _CreateCategoryScreenState();
}

class _CreateCategoryScreenState extends State<CreateCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String imageUrl = '';  // Only keeping attachment as imageUrl

  Future<void> addCategory() async {  // Renamed to addCategory
    final url = 'http://malegend.samrach.pro:8000/categories';  // API URL for categories
    final body = json.encode({
      "name": name,
      "attachment": imageUrl,
    });

    try {
      final response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'}, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Category added successfully!');
        Navigator.pop(context, true); // Return true to indicate success
      } else {
        throw Exception('Failed to add category');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Category'),
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
                validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Attachment (Image URL)'),
                onSaved: (value) => imageUrl = value ?? '',
                validator: (value) => value!.isEmpty ? 'Please enter an image URL' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    addCategory();  // Call addCategory when form is valid
                  }
                },
                child: Text('Add Category'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
