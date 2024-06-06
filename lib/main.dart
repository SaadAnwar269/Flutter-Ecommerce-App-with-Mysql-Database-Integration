import 'package:databaseproject/pages/favorites.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'pages/cart.dart';
import 'pages/product_details.dart';
import 'models/products.dart';
import 'old/welcome.dart';
import 'old/profile.dart';
import 'package:flutter_svg/svg.dart';
import 'pages/about.dart';


void main() {
  runApp(const MyApp());
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200, // Adjust the height as needed
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0), // Add padding around the image
              child: Image.network(
                'http://192.168.10.7/${product.imageUrl}',
                fit: BoxFit.contain,
                alignment: Alignment.center, // Center the image
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const Flexible(
            // Wrap the price text with Flexible
            child: Padding(
              padding: EdgeInsets.all(8.0),
            ),
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product App',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Josefin"),
      home: const WelcomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  final String email;

  const HomePage({super.key, required this.email});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<int> _userId;
  late Future<List<Product>> _products;

  @override
  void initState() {
    super.initState();
    _userId = fetchUserId(widget.email);
    _products = fetchProducts();
  }

  Future<int> fetchUserId(String email) async {
    final response =
    await http.get(Uri.parse('http://192.168.10.7/databaseproject/get_user_id.php?email=$email'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse.containsKey('Id')) {
        return int.parse(jsonResponse['Id']);
      } else {
        throw Exception('Failed to load user ID');
      }
    } else {
      throw Exception('Failed to load user ID');
    }
  }

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('http://192.168.10.7/databaseproject/get_products.php'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
        future: _userId,
        builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData) {
        return const Center(child: Text('No user ID found'));
      } else {
        int userId = snapshot.data!;
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'HOME',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage(userId: userId)),
                    );
                  },
                  child: const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar.jpg'),
                  ),
                ),
              ),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.green[200],
                  ),
                  child: const Text(
                    'Menu',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 35,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0,left: 8),
                  child: TextField(
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Arial',
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.green[200],
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset("assets/icons/Search.svg"),
                      ),
                      hintText: "Search for a product",
                      hintStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: 'Renita-Montes',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: const Icon(Icons.favorite),
                  title: const Text('Favorites',style: TextStyle(fontWeight: FontWeight.bold),),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>FavoritesPage()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('About Us',style: TextStyle(fontWeight: FontWeight.bold),),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUsPage()));
                  },
                ),
              ],
            ),
          ),
          body:ListView(
              children: [
          const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Popular Right Now',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
                SizedBox(
                  height: 250,
                  child: FutureBuilder<List<Product>>(
                    future: _products,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No products found'));
                      } else {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var product = snapshot.data![index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailsPage(
                                      product: product,
                                      userId: userId, // Assuming you have access to userId here
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.green[100],
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 16.0),
                                        child: Container(
                                          width: 150 * 0.85,
                                          height: 150 * 0.85,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: ClipOval(
                                            child: Image.network(
                                              'http://192.168.10.7/${product.imageUrl}',
                                              width: 150 * 0.75,
                                              height: 150 * 0.75,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 8.0,
                                        left: 8,
                                        right: 8,
                                        child: Text(
                                          product.title,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'All Products',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FutureBuilder<List<Product>>(
                  future: _products,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No products found'));
                    } else {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2 / 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var product = snapshot.data![index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailsPage(
                                    product: product,
                                    userId: userId,
                                  ),
                                ),
                              );
                            },
                            child: ProductCard(product: product),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.red),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Cart',
              ),
            ],
            selectedItemColor: Colors.red,
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            onTap: (index) {
              if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage(userId: userId)),
                );
              }
            },
          ),

        );
      }
        },
    );
  }
}