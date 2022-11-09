class Address{
  final String name;
  final String houseNum;
  final String village;
  final String district;
  final String state;
  final String pinCode;
  final bool? isDefault;

  Address({
    required this.name, required this.houseNum, required this.village, required this.district, required this.state, required this.pinCode, required this.isDefault
    }
  );

  Map<String,dynamic> toMap() {
    return {
      "name": name,
      "houseNum": houseNum,
      "village": village,
      "district": district,
      "state": state,
      "pinCode": pinCode,
      "isDefault": isDefault,
    };
  }
}