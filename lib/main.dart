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
              child: Text('ដំណើរ',
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
                  'ធ្វើដំណើរទៅកាន់គ្រប់ទីកន្លែងក្នុងព្រះរាជាណាចក្រកម្ពុជា!',
                  style: GoogleFonts.suwannaphum(
                      fontSize: 15, color: Colors.black),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomIconButton(
                      label: 'Hotel',
                      icon: Icons.hotel,
                      backgroundColor: Colors.cyan.shade300,
                      onPressed: () {},
                    ),
                    CustomIconButton(
                      label: 'រថភ្លើង',
                      icon: Icons.train,
                      backgroundColor: Colors.deepPurpleAccent.shade100,
                      onPressed: () {},
                    ),
                    CustomIconButton(
                      label: 'ឡានក្រុង',
                      icon: Icons.directions_bus_filled_outlined,
                      backgroundColor: Colors.pinkAccent.shade100,
                      onPressed: () {},
                    ),
                    CustomIconButton(
                      label: 'យន្តហោះ',
                      icon: Icons.flight_takeoff,
                      backgroundColor: Colors.greenAccent.shade100,
                      onPressed: () {},
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                Text('ទីតាំងស្នាក់នៅ',
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
                                text: 'ទាំងអស់',
                                backgroundColor: Colors.white10,
                                onPressed: () {}),
                            CustomElevatedButton(
                                text: 'សៀមរាប',
                                backgroundColor: Colors.white70,
                                onPressed: () {}),
                            CustomElevatedButton(
                                text: 'ភ្នំពេញ',
                                backgroundColor: Colors.white70,
                                onPressed: () {}),
                            CustomElevatedButton(
                                text: 'បាត់ដំបង',
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
                              'https://images.unsplash.com/photo-1566073771259-6a8506099945?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                              'Sabay Hotel'),
                          _imageCard(
                              'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                              'KH Resort'),
                          _imageCard(
                              'https://images.unsplash.com/photo-1455587734955-081b22074882?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                              'SR Boutique'),
                        ],
                      ),
                    )),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10)),
                Text('ទីតាំងរមនីយដ្ឋាន',
                    style: GoogleFonts.suwannaphum(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _imageCard(
                              'https://plus.unsplash.com/premium_photo-1661963188432-5de8a11f21a7?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                              'អង្គរវត្ត'),
                          _imageCard(
                              'https://s9.kh1.co/68/68ef5df81c7e491aa166e5ba16e9581cea0499b7.jpg',
                              'ក្រុងបាត់ដំបង'),
                          _imageCard(
                              'http://www.neverendingvoyage.com/wp-content/uploads/2014/03/durian-statue-kampot-cambodia-933x700.jpg',
                              'ខេត្តកំពត'),
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