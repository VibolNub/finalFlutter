import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

import 'detail.dart'; // Import your ProductDetail screen.

class ProductListingScreen extends StatefulWidget {
  final String? selectedCategoryId;
  final String? selectedCategory;

  const ProductListingScreen({Key? key, this.selectedCategoryId, this.selectedCategory}) : super(key: key);

  @override
  _ProductListingScreenState createState() => _ProductListingScreenState();
}


class _ProductListingScreenState extends State<ProductListingScreen> {
  final String productUrl = "http://malegend.samrach.pro:8000/products";
  final String categoryUrl = "http://malegend.samrach.pro:8000/categories";
  List<dynamic>? products;
  List<dynamic>? filteredProducts;
  List<String> categories = [];
  bool isLoading = true;
  String? selectedCategory; // To store selected category name
  String? selectedCategoryId; // To store selected category id
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Set the initial category based on the passed parameters
    selectedCategory = widget.selectedCategory;
    selectedCategoryId = widget.selectedCategoryId;

    fetchCategories(); // Load categories
    fetchProducts(selectedCategoryId); // Fetch products for the selected category
    _searchController.addListener(() {
      filterProducts();
    });
  }



  // Fetch categories and map them to category id and name
  Map<String, String> categoryMap = {}; // Maps category name to category id

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse(categoryUrl));
      if (response.statusCode == 200) {
        final categoryList = json.decode(response.body);
        setState(() {
          categoryMap = {
            for (var category in categoryList) category['name']: category['id']
          };
          categories = categoryMap.keys.toList(); // List of category names
          categories.insert(0, 'All'); // Add 'All' as a default option
        });
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print(e);
    }
  }

  // Fetch products based on the selected category
  Future<void> fetchProducts([String? categoryId]) async {
    try {
      print("fetchProducts called with categoryId: $categoryId");
      String url = (categoryId == null || categoryId.isEmpty)
          ? productUrl // Fetch all products
          : "$categoryUrl/$categoryId"; // Fetch products by category

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          products = json.decode(response.body);
          filteredProducts = products; // Initially, set filteredProducts to all products
          isLoading = false;
        });

        // After fetching products, filter based on the current search and category
        filterProducts();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching products: $e");
    }
  }

  // Filter products based on search text and selected category
  void filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredProducts = products?.where((product) {
        final matchesSearchQuery = query.isEmpty || product['name'].toLowerCase().contains(query);
        final matchesCategory = selectedCategory == null ||
            selectedCategory == 'All' ||
            product['category_id'] == selectedCategoryId;
        return matchesSearchQuery && matchesCategory;
      }).toList();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Listing', style: GoogleFonts.suwannaphum()),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    hintStyle: GoogleFonts.suwannaphum(),
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  style: GoogleFonts.suwannaphum(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  value: selectedCategory, // Bind to the state variable
                  hint: Text(
                    'Select Category',
                    style: GoogleFonts.suwannaphum(),
                  ),
                  items: categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(
                        category,
                        style: GoogleFonts.suwannaphum(),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                      selectedCategoryId = value == 'All' || value == null
                          ? ''
                          : categoryMap[value] ?? '';
                      isLoading = true;
                      fetchProducts(selectedCategoryId);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : (filteredProducts == null || filteredProducts!.isEmpty)
          ? Center(
        child: Text(
          filteredProducts == null
              ? 'Failed to load products'
              : 'No products found',
          style: GoogleFonts.suwannaphum(),
        ),
      )
          : GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.9,
        ),
        itemCount: filteredProducts!.length,
        itemBuilder: (context, index) {
          final product = filteredProducts![index];
          return product == null
              ? SizedBox.shrink() // Handle null gracefully
              : GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetail(
                    productId: product['id'],
                  ),
                ),
              );
            },
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12.0)),
                    child: Image.network(
                      product['attachment'] ?? 'https://via.placeholder.com/150',
                      width: double.infinity,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.error),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: Text(
                      product['name'] ?? 'Unknown Product',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.suwannaphum(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      product['price'] != null
                          ? '\$${product['price']}'
                          : 'No Price',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.suwannaphum(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }}
