import 'package:cattle_guru/features/community/ui/widgets/podcast_tile.dart';
import 'package:cattle_guru/models/address.dart';
import 'package:cattle_guru/models/cart_model.dart';
import 'package:cattle_guru/models/order_model.dart';
import 'package:cattle_guru/models/product_categories.dart';
import 'package:cattle_guru/models/product_details.dart';
import 'package:cattle_guru/models/room_tile_model.dart';
import 'package:cattle_guru/models/short_video.dart';
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


//VIDEO THUMBNAILS
List videoThumbnails = [
  Video(videoUrl: "https://www.youtube.com/watch?v=DL3wYGDqigc", thumbUrl: "https://i.ytimg.com/vi/DL3wYGDqigc/hqdefault.jpg", name: "गायों को कैसे खिलाएं | Cattle Care Course #1"),
  Video(videoUrl: "https://www.youtube.com/watch?v=Z8gxjZr0VvQ", thumbUrl: "https://i.ytimg.com/vi/Z8gxjZr0VvQ/hqdefault.jpg", name: "गायों को कैसे खिलाएं | Cattle Care Course #2"),
  Video(videoUrl: "https://www.youtube.com/watch?v=Z8gxjZr0VvQ", thumbUrl: "https://i.ytimg.com/vi/Hz6FACYKa0w/hqdefault.jpg", name: "गायों को कैसे खिलाएं | Cattle Care Course #3"),
];

//PRODUCT TILES
List productTiles = [
  ProductDetail(
    category: "Feed",
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
    category: "Khal",
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
    category: "Binola",
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
  // OrderModel(order: cartItems, date: DateTime.now().subtract(const Duration(days: 2)), amount: 3550),
  // OrderModel(order: cartItems, date: DateTime.now().subtract(const Duration(days: 5)), amount: 1440),
  // OrderModel(order: cartItems, date: DateTime.now().subtract(const Duration(days: 7)), amount: 950),
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
  [
    BottomNavigationBarItem(
        backgroundColor: primary,
        icon: Icon(
          Icons.home_filled,
        ),
        label: isEnglish ? "Home" : "घर",
      ),
      BottomNavigationBarItem(
        backgroundColor: primary,
        icon: Icon(
          Icons.local_shipping_rounded,
        ),
        label: isEnglish ? "Feed" : "चारा",
      ),
      BottomNavigationBarItem(
        backgroundColor: primary,
        icon: Icon(
          Icons.people_rounded,
        ),
        label: isEnglish ? "Community" : "समुदाय",
      ),
      BottomNavigationBarItem(
        backgroundColor: primary,
        icon: Icon(
          Icons.shopping_cart_rounded,
        ),
        label: isEnglish ? "Cart" : "कार्ट",
      ),     
];

//FIRESTORE AUX
List allUsersId = [];
String userName = "";
String phoneNumber = "";
String profileImgUrl = "";
String currentUserName = "";
bool isEnglish = true;
List transactions = [];
double walletBalance = 0;
List products2 = [];
List cart = [];
List<Map<String, dynamic>> products = [];
int qty = 0;
List addresses = [];
Map<String, dynamic> firestoreCurrentAddress = {};
List currentOrders = [];
double buyNowValue = 0;
double auxBuyNowValue = 0;

String categoryAux = "";

List selectedCategories = [];

List roomBgImageUrls = [
  "room_tile_bg_green.png",
  "room_tile_bg_blue.png",
];

List roomTiles = [
  RoomTileModel(title: "Room 1", description: "Tells us about cattles and buffaloes", 
  membersPhotos: [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRKouGaC5wkHjgKIuSSZTrTBBQWc5gEIOPFw&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLyv_x54sCOEJeHfGzdOLmz-MuPgyEcBmpew&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7jpCppYa2fnz2tELyJx5bwVsVvuYddBaHrg&usqp=CAU",
  ], 
  membersNames: [
    "Emma Stone",
    "Gal Gadot",
    "Robert De Niro",
  ],
  startedOn: DateTime.now(),),
  RoomTileModel(title: "Room 2", description: "Tells us about cattles and buffaloes", 
  membersPhotos: [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlIUxQKQmx5ouc6Tzxb3SMgA209BiV9fDIduXvUo_zwg&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDWw8Vdm9JSAzsSu6MANcNR3pE0wZOISapEA&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDdNnMh6qmlMex0So-_YFdmGRqzoWEFTweew&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZQhr1anKVzAaHQtvVh3eiGojjQurDszvkYQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwHxzyZ-W2EGSfaxeGfC1OrfG8xYYb_C0UEQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSYFB_2i64cYo12_9Z0lfEWcm49eHllO0BPQ&usqp=CAU",
  ],
  membersNames: [
    "Adam Sandler",
    "Marlon Brando",
    "Olivia Wilde",
    "Hale Berry",
    "Jason Statham",
    "Vin Diesel",
  ], 
  startedOn: DateTime.now(),),
  RoomTileModel(title: "Room 3", description: "Tells us about cattles and buffaloes", 
  membersPhotos: [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTwNQE4rpxRJAg2UsOR1NG0WVs_cyj2n1hjA&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwQy2bsuH1e8PgeKgvwK5gjfyyQbwMwBsBGA&usqp=CAU",
  ], 
  membersNames: [
    "Selena Gomez",
    "Justin Bieber",
  ],
  startedOn: DateTime.now(),),
  RoomTileModel(title: "Room 4", description: "Tells us about cattles and buffaloes", 
  membersPhotos: [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsUmE6FMTWUnXwdX_vkq9XMe_6AIFuuBY_lQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSrdB8rRgA1qgkw0ckcTrhIa0kpV2ILvbMWg&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIrn_wp1oOgzbSMezQBZKQNBzthtW8-NrRtA&usqp=CAU",
  ], 
  membersNames: [
    "James Franco",
    "Tobie Maguire",
    "Kirsten Dunst",
  ],
  startedOn: DateTime.now(),),
  RoomTileModel(title: "Room 5", description: "Tells us about cattles and buffaloes", 
  membersPhotos: [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoyedv8JUlJy8dVx44OSYBkYc-1P-K57vh9A&usqp=CAU",
  ], 
  membersNames: [
    "Meryl Streep"
  ],
  startedOn: DateTime.now(),),
];

List experts = [
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoyedv8JUlJy8dVx44OSYBkYc-1P-K57vh9A&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIrn_wp1oOgzbSMezQBZKQNBzthtW8-NrRtA&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsUmE6FMTWUnXwdX_vkq9XMe_6AIFuuBY_lQ&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSrdB8rRgA1qgkw0ckcTrhIa0kpV2ILvbMWg&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTwNQE4rpxRJAg2UsOR1NG0WVs_cyj2n1hjA&usqp=CAU",
];

List podcastTiles = [
  PodcastTile(
    onTap: (){}, 
    podcastImgUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxaXIHbbcN9DsafuKGRh7DIELlEsM3yccHmg&usqp=CAU", 
    podcastTitle: "Podcast 1", 
    podcastDate: DateTime.now(), 
    podcastDuration: 400, 
    onPlay: (){},
  ),
  PodcastTile(
    onTap: (){}, 
    podcastImgUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCwabrqq9KuWO7scRKYSZrFkM9KnAn7CP6VQ&usqp=CAU", 
    podcastTitle: "Podcast 2", 
    podcastDate: DateTime.now().subtract(Duration(days: 2)), 
    podcastDuration: 265, 
    onPlay: (){},
  ),
  PodcastTile(
    onTap: (){}, 
    podcastImgUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmj1wcDCmUlN9oRlQsrlv3ocgZzvQM0j1Z6Q&usqp=CAU", 
    podcastTitle: "Podcast 3", 
    podcastDate: DateTime.now().subtract(Duration(days: 4)), 
    podcastDuration: 938, 
    onPlay: (){},
  ),
];

List<Map<String, dynamic>> khalProducts = [];
List<Map<String, dynamic>> binolaProducts = [];
List<Map<String, dynamic>> feedProducts = [];
List<Map<String, dynamic>> silageProducts = [];

List productsKhal = [];
List productsBinola = [];
List productsFeed = [];
List productsSilage = [];

Map<String, dynamic> buyNowProduct = {};

String razorpayId = "rzp_live_hUk8LTeESrQ6lL";
String razorpaySecret = "y66gUaAmox673dMiGkBaaNik";

List shortVideoUrls = [
  ShortVideo(videoUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4", name: "Video 1", description: "This is the first video", likes: 10, dislikes: 3, comments: 2),
  ShortVideo(videoUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", name: "Video 2", description: "This is the second video", likes: 7, dislikes: 1, comments: 4),
  ShortVideo(videoUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4", name: "Video 3", description: "This is the third video", likes: 15, dislikes: 2, comments: 7),
  // "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
  // "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  // "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
];