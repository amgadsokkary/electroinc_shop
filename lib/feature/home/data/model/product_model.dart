class ProductModel {
  final int id;
  final DateTime createdAt;
  final String name;
  final String image;
  final String category;
  final num price;
  final int quantity;
  final String detail;
  final int review;

  ProductModel({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.image,
    required this.category,
    required this.price,
    required this.quantity,
    required this.detail,
    required this.review,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      name: json['name'],
      image: json['image'],
      category: json['category'] ?? "",
      price: (json['price']).toDouble(),
      quantity: json['quantity'] ?? 0,
      detail: json['detail'] ?? "",
      review: json['review'] ?? 0,
    );
  }
}
