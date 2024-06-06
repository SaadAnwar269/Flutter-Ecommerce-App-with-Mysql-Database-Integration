import 'package:flutter/material.dart';

class TextEditingControllers {
  // Singleton instance
  static final TextEditingControllers _instance = TextEditingControllers._internal();

  // Private constructor
  TextEditingControllers._internal();

  // Factory method to access the singleton instance
  factory TextEditingControllers() => _instance;

  // Text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController dAddressController = TextEditingController();
  final TextEditingController bAddressController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
}
