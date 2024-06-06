
class Product{
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final bool isFavourite;
  final bool isPopular;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.isFavourite,
    required this.isPopular,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: int.parse(json['id']),
      title: json['title'],
      description: json['description'],
      imageUrl: json['image_url'],
      price: double.parse(json['price'].toString()),
      isFavourite: json['is_favourite'] == 1,
      isPopular: json['is_popular'] == 1,
    );
  }
}
