class IncomeModel{
  final String id;
  final String title;
  final double amount;
  final String source;
  final DateTime date;

  IncomeModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.source,
    required this.date,
  });

  Map<String,dynamic> toMap(){
    return{
      'title':title,
      'amount':amount,
      'source':source,
      'date':date
    };
  }

  factory IncomeModel.fromMap(
      String id,
      Map<String,dynamic> map,
      ){
    return IncomeModel(
        id: id,
        title: map['title'],
        amount: (map['amount'] as num).toDouble(),
        source: map['source'],
        date: map['date'].toDate()
    );
  }

}