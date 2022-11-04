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
  ProductCategories("./assets/images/product_categories/khal.png", "Khal"),
  ProductCategories("./assets/images/product_categories/binola.png", "Binola"),
  ProductCategories("./assets/images/product_categories/feed.png", "Feed"),
  ProductCategories("./assets/images/product_categories/silage.png", "Silage"),
];

//VIDEO THUMBNAILS
List videoThumbnails = [
  VideoThumbnail("./assets/images/video_thumbnails/video_thumb_1.png", "Video 1"),
  VideoThumbnail("./assets/images/video_thumbnails/video_thumb_2.png", "Video 2"),
  VideoThumbnail("./assets/images/video_thumbnails/video_thumb_3.png", "Video 3"),
];

//PRODUCT TILES
List productTiles = [
  ProductDetail(
    ["./assets/images/products/product_1.png"], 
    "GURU's Pashu Ahar", 
    399, 
    449,
    45,
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor in cididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam",
    35,
    45,
    20,
    13,
    1,
    2,
  ),
  ProductDetail(
    ["./assets/images/products/product_1.png"], 
    "GURU's Pashu Ahar", 
    750, 
    875,
    35,
    "Mixed with all good nutrients, this is made specially for cows",
    35,
    45,
    20,
    24,
    2,
    3,
  ),
  ProductDetail(
    ["./assets/images/products/product_1.png"], 
    "GURU's Pashu Ahar", 
    650, 
    900,
    45,
    "Mixed with all good nutrients, this is made specially for buffaloes",
    50,
    45,
    20,
    5,
    2,
    3,
  ),
];

//CART TILES
List<CartModel> cartItems = [
  CartModel(productTiles[0], 2),
  CartModel(productTiles[2], 3),
];

//CART VALUE
double cartValue = 0;

//CURRENT ORDER
OrderModel currentOrder = OrderModel(cartItems, DateTime.now(), 2448);

//PREVIOUS ORDERS
List previousOrders = [
  OrderModel(cartItems, DateTime.now().subtract(const Duration(days: 2)), 3550),
  OrderModel(cartItems, DateTime.now().subtract(const Duration(days: 5)), 1440),
  OrderModel(cartItems, DateTime.now().subtract(const Duration(days: 7)), 950),
];

//ADDRESS TILES
List addressTiles = [
  Address("Vaibhav Aggarwal", "45-A", "Karol Bagh", "Delhi", "New Delhi", "123123", true),
  Address("Ayan Dasgupta", "Mint 1202, Siddha Happyville", "New Town", "North 24 Parganas", "West Bengal", "700135", false),
  Address("Reshmita Datta", "B/146", "Survey Park", "Kolkata", "West Bengal", "700075", false),
];

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