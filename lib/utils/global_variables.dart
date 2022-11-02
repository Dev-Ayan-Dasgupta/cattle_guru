import 'package:cattle_guru/features/home/ui/widgets/product_tile.dart';
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
const grey = Colors.grey;
const white = Colors.white;
const lightGrey = Color.fromARGB(255, 233, 233, 233);
const black = Colors.black;
const red = Color(0xFFFF0101);
const lightRed = Color.fromRGBO(255, 1, 1, 0.1);

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
  ProductDetail("./assets/images/products/product_1.png", "GURU's Pashu Ahar", 399, "Mixed with all good nutrients, this is made specially"),
  ProductDetail("./assets/images/products/product_1.png", "GURU's Pashu Silage", 499, "Mixed with all good nutrients, this is made specially"),
  ProductDetail("./assets/images/products/product_1.png", "GURU's Pashu Fertilizer", 599, "Mixed with all good nutrients, this is made specially"),
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