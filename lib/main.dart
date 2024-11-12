import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
                  style: GoogleFonts.suwannaphum(
                      fontSize: 30, fontWeight: FontWeight.w600)),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Browse your dream items',
                  style: GoogleFonts.suwannaphum(
                      fontSize: 15, color: Colors.black),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomIconButton(
                      label: "Deals",
                      icon: Icons.discount,
                      backgroundColor: Colors.cyan.shade300,
                      onPressed: () {},
                    ),
                    CustomIconButton(
                      label: 'Indoor',
                      icon: Icons.living,
                      backgroundColor: Colors.deepPurpleAccent.shade100,
                      onPressed: () {},
                    ),
                    CustomIconButton(
                      label: 'Outdoor',
                      icon: Icons.outdoor_grill,
                      backgroundColor: Colors.pinkAccent.shade100,
                      onPressed: () {},
                    ),
                    CustomIconButton(
                      label: 'Kitchen',
                      icon: Icons.kitchen,
                      backgroundColor: Colors.greenAccent.shade100,
                      onPressed: () {},
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                Text('Featured',
                    style: GoogleFonts.suwannaphum(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CustomElevatedButton(
                                text: 'All',
                                backgroundColor: Colors.white10,
                                onPressed: () {}),
                            CustomElevatedButton(
                                text: 'Bed',
                                backgroundColor: Colors.white70,
                                onPressed: () {}),
                            CustomElevatedButton(
                                text: 'Sofa',
                                backgroundColor: Colors.white70,
                                onPressed: () {}),
                            CustomElevatedButton(
                                text: 'Kitchen',
                                backgroundColor: Colors.white70,
                                onPressed: () {}),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _imageCard(
                              'https://assets.wfcdn.com/im/22026551/resize-h800-w800%5Ecompr-r85/2823/282395311/Hegg+Tufted+Upholstered+Platform+Bed%2C+Light+Gray%2C+Queen.jpg',
                              'Hegg Tufted Upholstered Platform Bed'),
                          _imageCard(
                              'https://assets.wfcdn.com/im/38032778/resize-h800-w800%5Ecompr-r85/2909/290930839/Bentura+83.86%27%27+Recessed+Arm+Modular+Sofa.jpg',
                              'Recessed Arm Modular Sofa'),
                          _imageCard(
                              'https://assets.wfcdn.com/im/07412727/resize-h800-w800%5Ecompr-r85/2856/285697148/EAST+OAK+Electric+Smoker+Wood+Burning+Portable+725+Square+Inches+Smoker.jpg',
                              'EAST OAK Electric Smoker'),
                        ],
                      ),
                    )),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10)),
                Text('New Stocks',
                    style: GoogleFonts.suwannaphum(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _imageCard(
                              'https://assets.wfcdn.com/im/63982135/resize-h800-w800%5Ecompr-r85/1506/150639570/235.2%27+LED+300+-+Bulb+Icicle+Lights+String+Light.jpg',
                              'Bulb Icicle Lights String'),
                          _imageCard(
                              'https://assets.wfcdn.com/im/51262379/resize-h800-w800%5Ecompr-r85/2791/279131096/Aluminum+Patio+Gazebo%2C+12+Ft.+W+x+10+Ft.+D.jpg',
                              'Aluminum Patio Gazebo'),
                          _imageCard(
                              'https://assets.wfcdn.com/im/80328720/resize-h800-w800%5Ecompr-r85/2825/282590106/Garson+End+Table+Set.jpg',
                              'Drawer End Table with Storage'),
                        ],
                      ),
                    )),
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
                currentIndex: 0,
                // currentIndex: _selectedIndex,
                // onTap: _onItemTapped,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home, color: Colors.grey),
                    activeIcon: Icon(Icons.home, color: Colors.cyan),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.access_time, color: Colors.grey),
                    activeIcon: Icon(Icons.access_time, color: Colors.cyan),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.sticky_note_2, color: Colors.grey),
                    activeIcon: Icon(Icons.sticky_note_2, color: Colors.cyan),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person, color: Colors.grey),
                    activeIcon: Icon(Icons.person, color: Colors.cyan),
                    label: '',
                  ),
                ]),
          ),
        ));
  }
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

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: SizedBox(
        height: 30,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}