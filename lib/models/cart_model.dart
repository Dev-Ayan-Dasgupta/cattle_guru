import 'package:cattle_guru/models/product_details.dart';

class CartModel{
  final ProductDetail product;
  int qty;

  CartModel({
    required this.product, required this.qty
    }
  );

  Map<String, dynamic> toMap() {
    return {
      "product": product,
      "qty": qty,
    };
  }
}