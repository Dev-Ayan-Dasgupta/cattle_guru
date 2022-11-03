import 'package:cattle_guru/models/cart_model.dart';

class OrderModel{
  final List<CartModel> order;
  final DateTime date;
  final double amount;

  OrderModel(this.order, this.date, this.amount);
}