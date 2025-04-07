class ProductModel {
  final int id;
  final String name, imagePath;
  final double price;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
  });
}

final List<ProductModel> products = [
  ProductModel(
    id: 1,
    name: "Track Suit",
    price: 139.99,
    imagePath: "assets/cardImage1.png",
  ),
  ProductModel(
      id: 2,
      name: "Oversized Hoodie",
      price: 89.99,
      imagePath: "assets/cardImage2.png"),
  ProductModel(
      id: 3,
      name: "Oversized Hoodie 2",
      price: 89.99,
      imagePath: "assets/cardImage3.png"),
  ProductModel(
      id: 4,
      name: "Reflector Hoodie",
      price: 89.99,
      imagePath: "assets/cardImage4.png"),
  ProductModel(
      id: 5,
      name: "Track Suit",
      price: 139.99,
      imagePath: "assets/cardImage5.png"),
  ProductModel(
      id: 6,
      name: "Oversized Hoodie",
      price: 89.99,
      imagePath: "assets/cardImage6.png"),
];
final List<int> favouriteList = [1, 4];
