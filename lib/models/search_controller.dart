import 'package:flutter/material.dart';
import 'products.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchController {
  static final SearchController _instance = SearchController._internal();

  factory SearchController() {
    return _instance;
  }

  SearchController._internal();

  TextEditingController searchTextController = TextEditingController();
  List<Product> _allProducts = [];

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse('http://192.168.10.7/databaseproject/get_products.php'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      _allProducts = jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  List<Product> searchProducts(String query) {
    return _allProducts.where((product) {
      return product.title.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
