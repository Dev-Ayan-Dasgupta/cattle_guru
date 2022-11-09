import 'package:cattle_guru/models/address.dart';
import 'package:cattle_guru/models/cart_model.dart';
import 'package:cattle_guru/models/order_model.dart';
import 'package:cattle_guru/models/product_categories.dart';
import 'package:cattle_guru/models/product_details.dart';
import 'package:cattle_guru/models/video_thumbnails.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//LOGIN SCREEN CAROUSEL IMAGES
List<String> carouselImageList = [
  "./assets/images/login_c1.png",
  "./assets/images/login_c2.png",
  "./assets/images/login_c3.png",
];

//HOME SCREEN CAROUSEL IMAGES
List<String> carouselImageListHome = [
  "./assets/images/home_c1.png",
  "./assets/images/home_c2.png",
  "./assets/images/home_c3.png",
  "./assets/images/home_c4.png",
];

//COLORS
const primary = Color(0xFF27AE60);
const primaryLight = Color.fromRGBO(49, 161, 96, 0.10);
const primaryDark = Color.fromARGB(220, 32, 146, 80);
const grey = Colors.grey;
const white = Colors.white;
const lightGrey = Color.fromARGB(255, 233, 233, 233);
const black = Colors.black;
const red = Color(0xFFFF0101);
const lightRed = Color.fromRGBO(255, 1, 1, 0.1);
const orangeLight = Color.fromARGB(255, 251, 195, 111);
const transparent = Colors.transparent;

//TEXTSTYLES
TextStyle globalTextStyle = GoogleFonts.varela();

//PRODUCT CATEGORIES
List productCategories = [
  ProductCategories(imageUrl: "./assets/images/product_categories/khal.png", name: "Khal"),
  ProductCategories(imageUrl: "./assets/images/product_categories/binola.png", name: "Binola"),
  ProductCategories(imageUrl: "./assets/images/product_categories/feed.png", name: "Feed"),
  ProductCategories(imageUrl: "./assets/images/product_categories/silage.png", name: "Silage"),
];

//VIDEO THUMBNAILS
List videoThumbnails = [
  Video(videoUrl: "", thumbUrl: "./assets/images/video_thumbnails/video_thumb_1.png", name: "Video 1"),
  Video(videoUrl: "", thumbUrl: "./assets/images/video_thumbnails/video_thumb_2.png", name: "Video 2"),
  Video(videoUrl: "", thumbUrl: "./assets/images/video_thumbnails/video_thumb_3.png", name: "Video 3"),
];

//PRODUCT TILES
List productTiles = [
  ProductDetail(
    imgUrls: ["./assets/images/products/product_1.png"], 
    name: "GURU's Pashu Ahar", 
    price: 399, 
    mrp: 449,
    weight: 45,
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor in cididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam",
    protein: 35,
    fibre: 45,
    fat: 20,
    units: 13,
    isCarted: true,
    dispatchDays: 1,
    deliveryDays: 2,
  ),
  ProductDetail(
    imgUrls: ["./assets/images/products/product_1.png"], 
    name: "GURU's Pashu Ahar", 
    price: 750, 
    mrp: 875,
    weight: 35,
    description: "Mixed with all good nutrients, this is made specially for cows",
    protein: 35,
    fibre: 45,
    fat: 20,
    units: 24,
    isCarted: false,
    dispatchDays: 2,
    deliveryDays: 3,
  ),
  ProductDetail(
    imgUrls: ["./assets/images/products/product_1.png"], 
    name: "GURU's Pashu Ahar", 
    price: 650, 
    mrp: 900,
    weight: 45,
    description: "Mixed with all good nutrients, this is made specially for buffaloes",
    protein: 50,
    fibre: 45,
    fat: 20,
    units: 5,
    isCarted: false,
    dispatchDays: 2,
    deliveryDays: 3,
  ),
];

//CART TILES
List<CartModel> cartItems = [
  CartModel(product: productTiles[0], qty: 2),
  CartModel(product: productTiles[2], qty: 3),
];

//CART VALUE
double cartValue = 0;

//CURRENT ORDER
OrderModel currentOrder = OrderModel(order: cartItems, date: DateTime.now(), amount: 2448);

//PREVIOUS ORDERS
List previousOrders = [
  OrderModel(order: cartItems, date: DateTime.now().subtract(const Duration(days: 2)), amount: 3550),
  OrderModel(order: cartItems, date: DateTime.now().subtract(const Duration(days: 5)), amount:1440),
  OrderModel(order: cartItems, date: DateTime.now().subtract(const Duration(days: 7)), amount: 950),
];

//ADDRESS TILES
List addressTiles = [
  Address(name: "Vaibhav Aggarwal", houseNum: "45-A", village: "Karol Bagh", district: "Delhi", state: "New Delhi", pinCode: "123123", isDefault: false),
  Address(name: "Ayan Dasgupta", houseNum: "Mint 1202, Siddha Happyville", village: "New Town", district: "North 24 Parganas", state: "West Bengal", pinCode: "700135", isDefault: true),
  Address(name: "Reshmita Datta", houseNum: "B/146", village: "Survey Park", district: "Kolkata", state: "West Bengal", pinCode: "700075", isDefault: false),
];

//CURRENT ADDRESS
Address currentAddress = Address(name: "Ayan Dasgupta", houseNum: "Mint 1202, Siddha Happyville", village: "New Town", district: "North 24 Parganas", state: "West Bengal", pinCode: "700135", isDefault: true);

//BOTTOM NAVIGATION BAR
List<BottomNavigationBarItem> items = 
  const [
    BottomNavigationBarItem(
        backgroundColor: primary,
        icon: Icon(
          Icons.home_filled,
        ),
        label: "Home",
      ),
      BottomNavigationBarItem(
        backgroundColor: primary,
        icon: Icon(
          Icons.local_shipping_rounded,
        ),
        label: "Feed",
      ),
      BottomNavigationBarItem(
        backgroundColor: primary,
        icon: Icon(
          Icons.people_rounded,
        ),
        label: "Community",
      ),
      BottomNavigationBarItem(
        backgroundColor: primary,
        icon: Icon(
          Icons.shopping_cart_rounded,
        ),
        label: "Cart",
      ),     
];

//FIRESTORE AUX
List cart = [];
List products = [];
int qty = 0;
List firestoreAddresses = [];
Map<String, dynamic> firestoreCurrentAddress = {};