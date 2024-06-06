import 'package:flutter/material.dart';
import 'signup.dart'; // Import the SignupPage
import 'login.dart'; // Import the LoginPage

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    final double screenWidth = MediaQuery.of(context).size.width;
    // Calculate the diameter of the circle as 3/4 of the screen width
    final double circleDiameter = screenWidth * 0.85;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Saad Project',
          style: TextStyle(
            fontFamily: "Renita-Montes",
            color: Colors.white,
            fontSize: 40,
          ),
        ),
        backgroundColor: Colors.green[300],
        centerTitle: true,

      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/images/shopping1 - Copy.png",
          fit: BoxFit.cover),
          Center(
            child: Container(
              width: circleDiameter,
              height: circleDiameter,
              decoration: BoxDecoration(
                color: Colors.green[50], // Change this to the desired color
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'YOUR VERY OWN STORE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Renita-Montes",
                          color: Colors.green,
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[300], // Background color
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontFamily: 'Renita-Montes',
                          fontSize: 30,
                          color: Colors.white, // Text color
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[300], // Background color
                      ),
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          fontFamily: 'Renita-Montes',
                          fontSize: 30,
                          color: Colors.white, // Text color
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
