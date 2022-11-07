import 'package:cattle_guru/models/cart_model.dart';

class OrderModel{
  final List<CartModel> order;
  final DateTime date;
  final double amount;

  OrderModel({
    required this.order, required this.date, required this.amount
    }
  );

  Map<String, dynamic> toMap() {
    return {
      "order": order,
      "date": date,
      "amount": amount,
    };
  }
}