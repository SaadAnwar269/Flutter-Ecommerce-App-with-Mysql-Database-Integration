import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CartService {
  static Future<List<Map<String, dynamic>>> getCartItems(int userId) async {
    final response = await http.get(
      Uri.parse('http://192.168.10.7/databaseproject/get_cart.php?userId=$userId'),
    );

    if (response.statusCode == 200) {
      List<dynamic> cartItems = json.decode(response.body);
      return cartItems.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load cart items');
    }
  }

  static Future<void> addToCart(Map<String, dynamic> item, int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> cartItems = await getCartItems(userId);

    cartItems.add(item);
    await prefs.setString('cartItems', json.encode(cartItems));
  }


  static Future<void> deleteCartItem(int userId, int productId) async {
    final response = await http.post(
      Uri.parse('http://192.168.10.7/databaseproject/delete_cart_item.php'),
      body: {
        'userId': userId.toString(), // Convert userId to string
        'productId': productId.toString(), // Convert productId to string
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete cart item');
    }
  }



  static Future<void> clearCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('cartItems');
  }
}
