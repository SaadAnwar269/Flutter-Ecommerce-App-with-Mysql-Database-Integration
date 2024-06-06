import 'dart:convert';
import 'welcome.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'singleton.dart';

class SignupPage extends StatelessWidget {
  final TextEditingControllers _controllers = TextEditingControllers();

  TextEditingController get email => _controllers.emailController;
  TextEditingController get password => _controllers.passwordController;
  TextEditingController get confirmPassword => _controllers.confirmPasswordController;

  //String uri = "http://10.0.2.2/seproject/insert.php";
  String uri = "http://192.168.10.7/dbproject/insert.php";

  Future<void> insertrecord(BuildContext context) async {
    // Check if email and password fields are not empty
    if (email.text.isEmpty || password.text.isEmpty || confirmPassword.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Check if the email format is valid
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email address'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Check if password and confirm password match
    if (password.text != confirmPassword.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    try {
      var res = await http.post(Uri.parse(uri), body: {
        "email": email.text,
        "password": password.text,
      });

      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful'),
            duration: Duration(seconds: 2),
          ),
        );
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WelcomePage()),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed: ${response["error"]}'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text(
        'Sign Up Page',
        style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
    ),
    ),
    centerTitle: true,
    backgroundColor: Colors.green[300],
    ),
    body: Stack(
    fit: StackFit.expand,
    children: [
    Image.asset(
    'assets/images/shopping1 - Copy.png', // Path to your background image
    fit: BoxFit.cover,
    ),
    Center(
    child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    TextField(
    style: const TextStyle(
    fontSize: 20,
    fontFamily: 'Arial',
    color: Colors.white
    ),
    controller: email,
    decoration: InputDecoration(
    filled: true,
    fillColor: Colors.green[200], // Set container color
    hintText: 'Enter Email',
    hintStyle: const TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontFamily: 'Renita-Montes'
    ), // Set hint text color
    border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(20.0),
    ),
    contentPadding: const EdgeInsets.all(15.0),
    ),
    ),
    const SizedBox(height: 20),
    TextField(
    style: const TextStyle(
    fontSize: 20,
    fontFamily: 'Arial',
    color: Colors.white
    ),
    controller: password,
    obscureText: true,
    decoration: InputDecoration(
    filled: true,
    fillColor: Colors.green[200], // Set container color
    hintText: 'Enter Password',
    hintStyle: const TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontFamily: 'Renita-Montes'
    ), // Set hint text color
    border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(20.0),
    ),
    contentPadding: const EdgeInsets.all(15.0),
    ),
    ),
    const SizedBox(height: 20),
    TextField(
    style: const TextStyle(
    fontSize: 20,
    fontFamily: 'Arial',
    color: Colors.white
    ),
    controller: confirmPassword,
    obscureText: true,
    decoration: InputDecoration(
    filled: true,
    fillColor: Colors.green[200], // Set container color
    hintText: 'Confirm Password',
    hintStyle: const TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontFamily: 'Renita-Montes',
    ), // Set hint text color
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(20.0),
      ),
      contentPadding: const EdgeInsets.all(15.0),
    ),
    ),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () {
          insertrecord(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green[300],
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Text(
          'Sign Up',
          style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontFamily: 'Renita-Montes',
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    ],
    ),
    ),
    ),
    ],
    ),
      backgroundColor: Colors.white,
    );
  }
}

