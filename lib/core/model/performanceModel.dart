import 'package:cloud_firestore/cloud_firestore.dart';

class PerformanceModel{
  Timestamp date;
  bool status;
  String videolink;
  String perfcontent;

//<editor-fold desc="Data Methods">
  PerformanceModel({
    required this.date,
    required this.status,
    required this.videolink,
    required this.perfcontent,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PerformanceModel &&
          runtimeType == other.runtimeType &&
          date == other.date &&
          status == other.status &&
          videolink == other.videolink &&
          perfcontent == other.perfcontent);

  @override
  int get hashCode =>
      date.hashCode ^
      status.hashCode ^
      videolink.hashCode ^
      perfcontent.hashCode;

  @override
  String toString() {
    return 'PerformanceModel{' +
        ' date: $date,' +
        ' status: $status,' +
        ' videolink: $videolink,' +
        ' perfcontent: $perfcontent,' +
        '}';
  }

  PerformanceModel copyWith({
    Timestamp? date,
    bool? status,
    String? videolink,
    String? perfcontent,
  }) {
    return PerformanceModel(
      date: date ?? this.date,
      status: status ?? this.status,
      videolink: videolink ?? this.videolink,
      perfcontent: perfcontent ?? this.perfcontent,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': this.date,
      'status': this.status,
      'videolink': this.videolink,
      'perfcontent': this.perfcontent,
    };
  }

  factory PerformanceModel.fromMap(Map<String, dynamic> map) {
    return PerformanceModel(
      date: map['date'] as Timestamp,
      status: map['status'] as bool,
      videolink: map['videolink'] ??"",
      perfcontent: map['perfcontent'] ??'',
    );
  }

//</editor-fold>
}