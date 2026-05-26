class ProductModel {
  final int id;

  final String name;

  final String description;

  final double price;

  final String imageUrl;

  final int stock;

  final String category;

  ProductModel({
    required this.id,

    required this.name,

    required this.description,

    required this.price,

    required this.imageUrl,

    required this.stock,

    required this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],

      name: json['name'],

      description: json['description'],

      price: double.parse(json['price'].toString()),

      imageUrl: json['imageUrl'],

      stock: json['stock'],

      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,

      "name": name,

      "description": description,

      "price": price,

      "imageUrl": imageUrl,

      "stock": stock,

      "category": category,
    };
  }
}
