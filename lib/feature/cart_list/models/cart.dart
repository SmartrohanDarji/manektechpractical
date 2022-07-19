class Cart {
  final String? productId;
  final String? productName;
  final int? price;
  final int quantity;
  final String? image;

  Cart(
      {required this.productId,
      required this.productName,
      required this.price,
      required this.quantity,
      required this.image});

  Cart.fromMap(Map<dynamic, dynamic> data)
      : productId = data['productId'],
        productName = data['productName'],
        price = data['price'],
        quantity = data['quantity'],
        image = data['image'];

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'price': price,
      'quantity': quantity,
      'image': image,
    };
  }
}
