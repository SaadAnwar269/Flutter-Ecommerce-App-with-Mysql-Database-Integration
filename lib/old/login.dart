import 'dart:convert';
import 'package:databaseproject/main.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'singleton.dart';

class LoginPage extends StatelessWidget {
  final TextEditingControllers _controllers = TextEditingControllers();

  LoginPage({super.key});

  TextEditingController get email => _controllers.emailController;
  TextEditingController get password => _controllers.passwordController;

  String uri = "http://192.168.10.7/dbproject/login.php";

  Future<void> login(BuildContext context) async {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      try {
        var res = await http.post(Uri.parse(uri), body: {
          "email": email.text,
          "password": password.text
        });

        var response = jsonDecode(res.body);
        if (response["success"] == "true") {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Login Successful'),
                duration: Duration(seconds: 2),
              )
          );
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(email: email.text,),
              ),
            );
          });
        } else {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login Failed'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("Fill all fields !!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Log In Page',
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
              fit: BoxFit.cover,
              "assets/images/shopping1 - Copy.png"),
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
                      fillColor: Colors.green[200],
                      hintText: 'Enter Email / ID',
                      hintStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Renita-Montes'
                      ),
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
                      fillColor: Colors.green[200],
                      hintText: 'Enter Password',
                      hintStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'Renita-Montes',
                          fontWeight: FontWeight.bold
                      ),
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
                      login(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[300],
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Log In',
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


