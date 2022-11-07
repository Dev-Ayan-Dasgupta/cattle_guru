class ProductCategories{
  final String imageUrl;
  final String name;

  ProductCategories({
      required this.imageUrl, required this.name,
    }
  );

  Map<String, dynamic> toMap() {
    return {
      "imageUrl": imageUrl,
      "name": name,
    };
  }
}