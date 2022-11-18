class ProductCategories{
  final String imageUrl;
  final String name;
  bool isSelected;

  ProductCategories({
      required this.imageUrl, required this.name, required this.isSelected,
    }
  );

  Map<String, dynamic> toMap() {
    return {
      "imageUrl": imageUrl,
      "name": name,
      "isSelected": isSelected,
    };
  }
}