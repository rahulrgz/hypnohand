
class RazorPayResponseModel{
  String price;
  double discount;
  String courseName;
  String docidcourse;
  String subName;
  Map<dynamic, dynamic> response;
  DateTime purchaseDate;

  RazorPayResponseModel({
    required this.price,
    required this.discount,
    required this.courseName,
    required this.docidcourse,
    required this.subName,
    required this.response,
    required this.purchaseDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'price': this.price,
      'discount': this.discount,
      'courseName': this.courseName,
      'docidcourse': this.docidcourse,
      'subName': this.subName,
      'response':this.response,
      'purchaseDate':this.purchaseDate,
    };
  }

  factory RazorPayResponseModel.fromMap(Map<String, dynamic> map) {
    return RazorPayResponseModel(
      price: map['price'] as String,
      discount: map['discount'] as double,
      courseName: map['courseName'] as String,
      docidcourse: map['docidcourse'] as String,
      subName: map['subName'] as String,
      response: map['response']as Map,
      purchaseDate: map['purchaseDate']as DateTime,
    );
  }

  RazorPayResponseModel copyWith({
    String? price,
    double? discount,
    String? courseName,
    String? docidcourse,
    String? subName,
    Map? response,
    DateTime?purchaseDate,
  }) {
    return RazorPayResponseModel(
      price: price ?? this.price,
      discount: discount ?? this.discount,
      courseName: courseName ?? this.courseName,
      docidcourse: docidcourse ?? this.docidcourse,
      subName: subName ?? this.subName,
      response: response??this.response,
      purchaseDate: purchaseDate??this.purchaseDate,
    );
  }
}