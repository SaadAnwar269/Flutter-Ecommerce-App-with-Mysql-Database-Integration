import 'package:flutter/material.dart';
import 'package:databaseproject/services/cart_service.dart';
import 'package:databaseproject/pages/checkout.dart';


class CartPage extends StatefulWidget {
  final int userId;

  CartPage({required this.userId});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<Map<String, dynamic>>> _cartItemsFuture;

  @override
  void initState() {
    super.initState();
    _cartItemsFuture = _loadCartItems();
  }

  Future<List<Map<String, dynamic>>> _loadCartItems() async {
    return await CartService.getCartItems(widget.userId);
  }

  String? _getImageUrl(Map<String, dynamic> cartItem) {
    String? imageUrl = cartItem['image_url'];
    if (imageUrl != null && !imageUrl.startsWith('http')) {
      imageUrl = 'http://192.168.10.7/$imageUrl'; // Concatenate with base URL if not already a complete URL
    }
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart',style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.green[300],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _cartItemsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No items in your cart'));
                } else {
                  List<Map<String, dynamic>> cartItems = snapshot.data!;
                  return ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> cartItem = cartItems[index];
                      int? productId = int.tryParse(cartItem['id']);
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: ListTile(
                          leading: Image.network(
                            _getImageUrl(cartItem) ?? '',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            cartItem['title'] ?? 'Unknown Product',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('\$${cartItem['price'] ?? '0.0'}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              if (productId != null) {
                                CartService.deleteCartItem(widget.userId, productId).then((_) {
                                  setState(() {
                                    // Refresh the future to trigger a rebuild
                                    _cartItemsFuture = _loadCartItems();
                                  });
                                }).catchError((error) {
                                  print('Error deleting item: $error');
                                });
                              } else {
                                print('Product ID is null');
                              }
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> CheckOut()));
              },
              child: const Text('CheckOut', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[300],
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
