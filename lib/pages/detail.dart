import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductDetail extends StatefulWidget {
  final String productId;

  const ProductDetail({required this.productId, Key? key}) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  late String productUrl;
  late String categoryUrl;
  Map<String, dynamic>? product;
  Map<String, String> categoryMap = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    productUrl = "http://malegend.samrach.pro:8000/products/${widget.productId}";
    categoryUrl = "http://malegend.samrach.pro:8000/categories";
    fetchProductAndCategories();
  }

  Future<void> fetchProductAndCategories() async {
    try {
      // Fetch product details
      final productResponse = await http.get(Uri.parse(productUrl));
      if (productResponse.statusCode != 200) {
        throw Exception('Failed to load product');
      }

      // Fetch categories
      final categoryResponse = await http.get(Uri.parse(categoryUrl));
      if (categoryResponse.statusCode != 200) {
        throw Exception('Failed to load categories');
      }

      final productData = json.decode(productResponse.body);
      final categories = json.decode(categoryResponse.body) as List<dynamic>;

      // Map category IDs to names
      final Map<String, String> tempCategoryMap = {};
      for (var category in categories) {
        tempCategoryMap[category['id']] = category['name'];
      }

      setState(() {
        product = productData;
        categoryMap = tempCategoryMap;
        isLoading = false;
      });
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
        title: Text('Product Detail'),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : product == null
          ? Center(child: Text('Failed to load product'))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product!['attachment'] ?? "https://picsum.photos/250",
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              product!['name'],
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '\$${product!['price']}',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            SizedBox(height: 8),
            Text(
              'Category: ${categoryMap[product!['category_id']] ?? 'Unknown'}',
              style: TextStyle(
                  fontSize: 16, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 16),
            Text(
              product!['description'],
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
                'Created at: ${product!['created_at']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {}, // Placeholder for add-to-cart functionality
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan.shade300,
                    ),
                    child: Text('Add to cart'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
