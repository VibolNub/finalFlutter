import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.cyan,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Profile Image
              CircleAvatar(
                radius: 150,
                backgroundImage: NetworkImage('https://shotkit.com/wp-content/uploads/2021/06/Cool-profile-picture-Zoom.jpg'), // Replace with user's image URL
                backgroundColor: Colors.grey[200],
              ),
              const SizedBox(height: 16),

              // Username
              Text(
                'John Smith',
                style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // Email
              Text(
                'johnsmith@example.com',
                style: GoogleFonts.lato(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(height: 8),

              // Birthday
              Text(
                'Birthday: January 16, 1992',
                style: GoogleFonts.lato(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(height: 24),

              // Edit Button
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to edit profile page or show edit dialog
                },
                icon: Icon(Icons.edit, color: Colors.white),
                label: Text('Edit Profile', style: GoogleFonts.lato(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Logout Button
              OutlinedButton.icon(
                onPressed: () {
                  // Implement logout logic here
                },
                icon: Icon(Icons.logout, color: Colors.red),
                label: Text(
                  'Log Out',
                  style: GoogleFonts.lato(fontSize: 18, color: Colors.red),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  side: BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
