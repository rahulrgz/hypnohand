import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hypnohand/core/model/coursedetails.dart';

class CourseModel{
  Timestamp date;
  String medium;
  String tutor;
  String coursename;
  List<CourseList> listcourselevel;

//<editor-fold desc="Data Methods">
  CourseModel({
    required this.date,
    required this.medium,
    required this.tutor,
    required this.coursename,
    required this.listcourselevel,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CourseModel &&
          runtimeType == other.runtimeType &&
          date == other.date &&
          medium == other.medium &&
          tutor == other.tutor &&
          coursename == other.coursename &&
          listcourselevel == other.listcourselevel);

  @override
  int get hashCode =>
      date.hashCode ^
      medium.hashCode ^
      tutor.hashCode ^
      coursename.hashCode ^
      listcourselevel.hashCode;

  @override
  String toString() {
    return 'CourseModel{' +
        ' date: $date,' +
        ' medium: $medium,' +
        ' tutor: $tutor,' +
        ' coursename: $coursename,' +
        ' listcourselevel: $listcourselevel,' +
        '}';
  }

  CourseModel copyWith({
    Timestamp? date,
    String? medium,
    String? tutor,
    String? coursename,
    List<CourseList>? listcourselevel,
  }) {
    return CourseModel(
      date: date ?? this.date,
      medium: medium ?? this.medium,
      tutor: tutor ?? this.tutor,
      coursename: coursename ?? this.coursename,
      listcourselevel: listcourselevel ?? this.listcourselevel,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': this.date,
      'medium': this.medium,
      'tutor': this.tutor,
      'coursename': this.coursename,
      'listcourselevel': this.listcourselevel,
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      date: map['date'] as Timestamp,
      medium: map['medium'] as String,
      tutor: map['tutor'] as String,
      coursename: map['coursename'] as String,
      listcourselevel: map['listcourselevel'] as List<CourseList>,
    );
  }

//</editor-fold>
}