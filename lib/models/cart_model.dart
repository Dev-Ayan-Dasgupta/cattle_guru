import 'package:cattle_guru/models/product_details.dart';

class CartModel{
  final ProductDetail product;
  int qty;

  CartModel(this.product, this.qty);
}