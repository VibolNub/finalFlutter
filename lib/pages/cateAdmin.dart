import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:midterm/pages/add.dart'; // Update these imports for category management
import 'package:midterm/pages/cateAdd.dart';
import 'package:midterm/pages/cateEdit.dart';
import 'package:midterm/pages/edit.dart';

class CategoryManagementScreen extends StatefulWidget {
  const CategoryManagementScreen({Key? key}) : super(key: key);

  @override
  _CategoryManagementScreenState createState() => _CategoryManagementScreenState();
}

class _CategoryManagementScreenState extends State<CategoryManagementScreen> {
  final String categoryUrl = "http://malegend.samrach.pro:8000/categories";
  List<dynamic>? categories;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse(categoryUrl));
      if (response.statusCode == 200) {
        setState(() {
          categories = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  void updateCategory(String categoryId) {
    print("Update category with ID: $categoryId");

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditCategoryScreen(categoryId: categoryId),
      ),
    ).then((result) {
      if (result == true) {
        fetchCategories();
      }
    });
  }

  Future<void> deleteCategory(String categoryId) async {
    final String deleteUrl = "http://malegend.samrach.pro:8000/categories/$categoryId";

    try {
      final response = await http.delete(Uri.parse(deleteUrl));

      if (response.statusCode == 200) {
        print("Category with ID: $categoryId deleted successfully.");
        fetchCategories();
      } else {
        print("Failed to delete category. Status code: ${response.statusCode}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete category: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print("Error deleting category: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred while deleting the category.')),
      );
    }
  }

  Future<void> navigateToCreateCategoryScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateCategoryScreen()),
    );

    if (result == true) {
      fetchCategories();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manage Categories',
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
          : categories == null
          ? Center(child: Text('Failed to load categories'))
          : ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        itemCount: categories!.length,
        itemBuilder: (context, index) {
          final category = categories![index];
          return Card(
            elevation: 2.0,
            margin: EdgeInsets.symmetric(vertical: 6.0),
            child: ListTile(
              title: Text(
                category['name'],
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
                      updateCategory(category['id']);
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
                            content: Text("Are you sure you want to delete this category?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  deleteCategory(category['id']);
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
        onPressed: navigateToCreateCategoryScreen,
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}

