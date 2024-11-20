import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductDetail extends StatefulWidget {
  final int productId;

  const ProductDetail({required this.productId, Key? key})
      : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  late String productUrl;
  Map<String, dynamic>? product;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    productUrl = "https://fakestoreapi.com/products/${widget.productId}";
    fetchProduct();
  }

  Future<void> fetchProduct() async {
    try {
      final response = await http.get(Uri.parse(productUrl));
      if (response.statusCode == 200) {
        setState(() {
          product = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load product');
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
                product!['image'],
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              product!['title'],
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '\$${product!['price']}',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            SizedBox(height: 8),
            Text(
              'Category: ${product!['category']}',
              style:
              TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 16),
            Text(
              product!['description'],
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow),
                SizedBox(width: 4),
                Text(
                  '${product!['rating']['rate']} (${product!['rating']['count']} reviews)',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 32),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: (){}, // This disables the button and ensures it does nothing when clicked.
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan.shade300, // Ensures the color remains consistent when disabled.
                    ),
                    child: Text('Add to cart'),
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
