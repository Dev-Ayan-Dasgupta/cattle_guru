class ProductDetail{
  final List<String> imgUrls;
  final String name;
  final double price;
  final double mrp;
  final double weight;
  final String description;
  final double protein;
  final double fibre;
  final double fat;
  final double units;
  final int dispatchDays;
  final int deliveryDays;

  ProductDetail({
    required this.imgUrls, required this.name, required this.price, required this.mrp, required this.weight, required this.description, required this.protein, required this.fibre, required this.fat, required this.units, required this.dispatchDays, required this.deliveryDays,
    }
  );

  Map<String, dynamic> toMap() {
    return {
      "imgUrls": imgUrls,
      "name": name,
      "price": price,
      "mrp": mrp,
      "weight": weight,
      "description": description,
      "protein": protein,
      "fibre": fibre,
      "fat": fat,
      "units": units,
      "dispatchDays": dispatchDays,
      "deliveryDays": deliveryDays,
    };
  }
}