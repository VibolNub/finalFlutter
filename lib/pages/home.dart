import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:midterm/pages/admin.dart';
import 'package:midterm/pages/cateAdmin.dart';
import 'package:midterm/pages/cateList.dart';
import 'dart:convert';

import 'package:midterm/pages/list.dart';
import 'package:midterm/pages/cateAdmin.dart';

void main() {
  runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int myIndex = 0;
  List<Map<String, dynamic>> categories = [];
  List<Map<String, dynamic>> products = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _fetchProducts();
  }

  Future<void> _fetchCategories() async {
    final response = await http.get(Uri.parse('http://malegend.samrach.pro:8000/categories'));
    if (response.statusCode == 200) {
      setState(() {
        categories = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      throw Exception('Failed to load categories');
    }
  }


  // Fetch Products from the API
  Future<void> _fetchProducts() async {
    final response = await http.get(Uri.parse('http://malegend.samrach.pro:8000/products'));
    if (response.statusCode == 200) {
      setState(() {
        products = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
            child: Text('E-Furniture',
                style: GoogleFonts.suwannaphum(fontSize: 30, fontWeight: FontWeight.w600)),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Browse your dream items',
                style: GoogleFonts.suwannaphum(fontSize: 15, color: Colors.black),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomIconButton(
                    label: "Products",
                    icon: Icons.shopping_cart,
                    backgroundColor: Colors.cyan.shade300,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  ProductListingScreen(),
                        ),
                      );

                    },
                  ),
                  CustomIconButton(
                    label: 'Category',
                    icon: Icons.format_list_bulleted_rounded,
                    backgroundColor: Colors.deepPurpleAccent.shade100,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CategoryListingScreen(),
                        ),
                      );

                    },
                  ),

                ],
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              Text('Featured Products',
                  style: GoogleFonts.suwannaphum(fontSize: 20, fontWeight: FontWeight.w600)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: products.isEmpty
                        ? [CircularProgressIndicator()]
                        : products.map((product) {
                      return _imageCard(
                        product['attachment'],
                        product['name'],
                      );
                    }).toList(),
                  ),
                ),
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10)),
              Text('Categories',
                  style: GoogleFonts.suwannaphum(fontSize: 20, fontWeight: FontWeight.w600)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categories.isEmpty
                        ? [CircularProgressIndicator()]
                        : categories.map((category) {
                      return _imageCard(
                        category['attachment'],
                        category['name'],
                      );
                    }).toList(),
                  ),
                ),
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5)),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8.0,
                spreadRadius: 2.0,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              elevation: 0,
              onTap: (index) {
                if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  ProductListingScreen()),
                  );
                } else if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CategoryListingScreen()),
                  );
                }
                else if (index == 3) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProductManagementScreen()),
                  );
                } else if (index == 4) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CategoryManagementScreen()),
                  );
                } else {
                  setState(() {
                    myIndex = index;
                  });
                }
              },
              currentIndex: myIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, color: Colors.grey),
                  activeIcon: Icon(Icons.home, color: Colors.cyan),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart, color: Colors.grey),
                  activeIcon: Icon(Icons.shopping_cart, color: Colors.cyan),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list, color: Colors.grey),
                  activeIcon: Icon(Icons.list, color: Colors.cyan),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.edit, color: Colors.grey),
                  activeIcon: Icon(Icons.edit, color: Colors.cyan),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.edit, color: Colors.grey),
                  activeIcon: Icon(Icons.edit, color: Colors.cyan),
                  label: '',
                ),
              ]),
        ),
      ),
    );
  }

  Widget _imageCard(String imageUrl, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8), // Space between the image and title
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13, // Adjust font size as needed
              fontWeight: FontWeight.w500, // Adjust font weight as needed
              color: Colors.grey, // Adjust color as needed
            ),
          ),
        ],
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const CustomIconButton({
    super.key,
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            backgroundColor: backgroundColor,
          ),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: GoogleFonts.suwannaphum(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
