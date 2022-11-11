class Transactions{
  final String purpose;
  final String date;
  final String amount;

  Transactions({
    required this.purpose, 
    required this.date, 
    required this.amount,
    }
  );

  Map<String, dynamic> toMap(){
    return {
      "purpose": purpose,
      "date": date,
      "amount": amount,
    };
  }
}