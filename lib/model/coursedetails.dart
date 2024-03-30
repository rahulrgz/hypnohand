import 'package:cloud_firestore/cloud_firestore.dart';

class CourseList{
  Timestamp date;
  String content;
  String tutor;
  int ordercode;
  String thumbnailimage;

//<editor-fold desc="Data Methods">
  CourseList({
    required this.date,
    required this.content,
    required this.tutor,
    required this.ordercode,
    required this.thumbnailimage,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CourseList &&
          runtimeType == other.runtimeType &&
          date == other.date &&
          content == other.content &&
          tutor == other.tutor &&
          ordercode == other.ordercode &&
          thumbnailimage == other.thumbnailimage);

  @override
  int get hashCode =>
      date.hashCode ^
      content.hashCode ^
      tutor.hashCode ^
      ordercode.hashCode ^
      thumbnailimage.hashCode;

  @override
  String toString() {
    return 'CourseList{' +
        ' date: $date,' +
        ' content: $content,' +
        ' tutor: $tutor,' +
        ' ordercode: $ordercode,' +
        ' thumbnailimage: $thumbnailimage,' +
        '}';
  }

  CourseList copyWith({
    Timestamp? date,
    String? content,
    String? tutor,
    int? ordercode,
    String? thumbnailimage,
  }) {
    return CourseList(
      date: date ?? this.date,
      content: content ?? this.content,
      tutor: tutor ?? this.tutor,
      ordercode: ordercode ?? this.ordercode,
      thumbnailimage: thumbnailimage ?? this.thumbnailimage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': this.date,
      'content': this.content,
      'tutor': this.tutor,
      'ordercode': this.ordercode,
      'thumbnailimage': this.thumbnailimage,
    };
  }

  factory CourseList.fromMap(Map<String, dynamic> map) {
    return CourseList(
      date: map['date'] as Timestamp,
      content: map['content'] as String,
      tutor: map['tutor'] as String,
      ordercode: map['ordercode'] as int,
      thumbnailimage: map['thumbnailimage'] as String,
    );
  }

//</editor-fold>
}