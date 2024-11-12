import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.cyan,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Box
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Type to search...',
                hintStyle: GoogleFonts.lato(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.search, color: Colors.cyan),
              ),
            ),
            const SizedBox(height: 20),
            // Search Button
            ElevatedButton(
              onPressed: () {
                _performSearch();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Search',
                style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _performSearch() {
    // Here, implement the search functionality based on `_searchController.text`
    final query = _searchController.text;
    if (query.isNotEmpty) {
      print('Searching for: $query');
      // Perform your search logic here
    }
  }
}
