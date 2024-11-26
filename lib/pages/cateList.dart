import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

class CategoryListingScreen extends StatefulWidget {
  const CategoryListingScreen({Key? key}) : super(key: key);

  @override
  _CategoryListingScreenState createState() => _CategoryListingScreenState();
}

class _CategoryListingScreenState extends State<CategoryListingScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categories Listing',
          style: GoogleFonts.suwannaphum(),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : categories == null
          ? Center(
        child: Text(
          'Failed to load categories',
          style: GoogleFonts.suwannaphum(),
        ),
      )
          : categories!.isEmpty
          ? Center(
        child: Text(
          'No categories found',
          style: GoogleFonts.suwannaphum(),
        ),
      )
          : GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 8.0, // Horizontal spacing
          mainAxisSpacing: 8.0, // Vertical spacing
          childAspectRatio: 1.0, // Makes cards closer to squares
        ),
        itemCount: categories!.length,
        itemBuilder: (context, index) {
          final category = categories![index];
          return Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12.0)),
                    child: Image.network(
                      category['attachment'] ?? '',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      category['name'] ?? 'Unnamed',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.suwannaphum(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}