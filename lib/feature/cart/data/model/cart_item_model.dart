class CartItemModel {
  final String id;
  final int productId;
  final String name;
  final num price;
  final String image;
  final int availableQuantity;
  final int cartQuantity;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.image,
    required this.availableQuantity,
    required this.cartQuantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    final product = json['product'];
    return CartItemModel(
      id: json['id'].toString(),
      productId: product['id'],
      name: product['name'],
      price: product['price'].toDouble(),
      image: product['image'],
      availableQuantity: product['quantity'],
      cartQuantity: json['quantity'],
    );
  }

  CartItemModel copyWith({int? cartQuantity}) {
    return CartItemModel(
      id: id,
      productId: productId,
      name: name,
      price: price,
      image: image,
      availableQuantity: availableQuantity,
      cartQuantity: cartQuantity ?? this.cartQuantity,
    );
  }
}
