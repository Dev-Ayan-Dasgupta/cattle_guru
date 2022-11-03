import 'package:cattle_guru/models/product_details.dart';

class CartModel{
  final ProductDetail product;
  final int qty;

  CartModel(this.product, this.qty);
}