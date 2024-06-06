import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[200],
        title: const Text(
          'About Us',
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontFamily: 'Renita-Montes',
          ),
        ),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to our Flutter App!',
              style: TextStyle(
                color: Colors.green,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: 'Renita-Montes',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'This is our first Flutter app, developed as a semester project for the course Database Systems.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Developers:',
              style: TextStyle(
                color: Colors.green,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Renita-Montes',
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Saad Anwar (Registration ID: B22F0460AI103)\nAroob Shahzad (Registration ID: B22F0007AI055)',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Institute:',
              style: TextStyle(
                color: Colors.green,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Renita-Montes',
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Pak Austria Fachhochschulle: Institute of Applied Sciences and Technology',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Program:',
              style: TextStyle(
                color: Colors.green,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Renita-Montes',
              ),
            ),
            SizedBox(height: 10),
            Text(
              'BS Artificial Intelligence',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}