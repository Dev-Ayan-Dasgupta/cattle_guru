import 'package:cattle_guru/models/address.dart';
import 'package:cattle_guru/models/cart_model.dart';
import 'package:cattle_guru/models/order_model.dart';
import 'package:cattle_guru/models/referral.dart';

class Customer{
  final String uid;
  final String phoneNumber;
  final bool isEnglish;
  final String profileImgUrl;
  final String name;
  final List<Transactions> transactions;
  final double walletBalance;
  final double cartValue;
  final List<CartModel> cart;
  final List<OrderModel> currentOrders;
  final List<OrderModel> orderHistory;
  final Map<String, dynamic> currentAddress;
  final List<Address> addresses;

  Customer({
    required this.uid, 
    required this.phoneNumber, 
    required this.isEnglish, 
    required this.profileImgUrl, 
    required this.name, 
    required this.transactions,
    required this.walletBalance, 
    required this.cartValue, 
    required this.cart,
    required this.currentOrders,
    required this.orderHistory, 
    required this.currentAddress, 
    required this.addresses,
    }
  );

  Map<String, dynamic> toMap(){
    return {
      "uid": uid,
      "phoneNumber": phoneNumber,
      "isEnglish": isEnglish,
      "profileImgUrl": profileImgUrl,
      "name": name,
      "transactions": transactions,
      "walletBalance": walletBalance,
      "cartValue": cartValue,
      "cart": cart,
      "currentOrders": currentOrders,
      "orderHistory": orderHistory,
      "currentAddress": currentAddress,
      "addresses": addresses,
    };
  }
}