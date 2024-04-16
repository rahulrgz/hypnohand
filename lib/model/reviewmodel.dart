import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  Timestamp date;



  String? reviewlink;


  bool status;


  String? thumbnail;

//<editor-fold desc="Data Methods">
  ReviewModel({
    required this.date,
    this.reviewlink,
    required this.status,
    this.thumbnail,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewModel &&
          runtimeType == other.runtimeType &&
          date == other.date &&
          reviewlink == other.reviewlink &&
          status == other.status &&
          thumbnail == other.thumbnail);

  @override
  int get hashCode =>
      date.hashCode ^
      reviewlink.hashCode ^
      status.hashCode ^
      thumbnail.hashCode;

  @override
  String toString() {
    return 'ReviewModel{' +
        ' date: $date,' +
        ' reviewlink: $reviewlink,' +
        ' status: $status,' +
        ' thumbnail: $thumbnail,' +
        '}';
  }

  ReviewModel copyWith({
    Timestamp? date,
    String? reviewlink,
    bool? status,
    String? thumbnail,
  }) {
    return ReviewModel(
      date: date ?? this.date,
      reviewlink: reviewlink ?? this.reviewlink,
      status: status ?? this.status,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': this.date,
      'reviewlink': this.reviewlink,
      'status': this.status,
      'thumbnail': this.thumbnail,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      date: map['date'] as Timestamp,
      reviewlink: map['reviewlink'] as String,
      status: map['status'] as bool,
      thumbnail: map['thumbnail'] as String ,
    );
  }

//</editor-fold>
}