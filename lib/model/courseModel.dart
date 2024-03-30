import 'package:cloud_firestore/cloud_firestore.dart';
CourseModel? coursemodell;
class CourseModel{
  final String coursename;
  final Timestamp date;
  final List<dynamic> listofstudents;
  final List<dynamic> listofvideo;
  final String medium;
  final String showprice;
  final String ogprice;
  final bool status;
  final String docid;
  final String thumbnailImage;
  final String tutor;
  final String demovideolink;
  final List search;
  final String subname;

//<editor-fold desc="Data Methods">
  const CourseModel({
    required this.coursename,
    required this.date,
    required this.listofstudents,
    required this.listofvideo,
    required this.medium,
    required this.showprice,
    required this.ogprice,
    required this.status,
    required this.docid,
    required this.thumbnailImage,
    required this.tutor,
    required this.demovideolink,
    required this.search,
    required this.subname,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CourseModel &&
          runtimeType == other.runtimeType &&
          coursename == other.coursename &&
          date == other.date &&
          listofstudents == other.listofstudents &&
          listofvideo == other.listofvideo &&
          medium == other.medium &&
          showprice == other.showprice &&
          ogprice == other.ogprice &&
          status == other.status &&
          docid == other.docid &&
          thumbnailImage == other.thumbnailImage &&
          tutor == other.tutor &&
          demovideolink == other.demovideolink &&
          search == other.search &&
          subname == other.subname);

  @override
  int get hashCode =>
      coursename.hashCode ^
      date.hashCode ^
      listofstudents.hashCode ^
      listofvideo.hashCode ^
      medium.hashCode ^
      showprice.hashCode ^
      ogprice.hashCode ^
      status.hashCode ^
      docid.hashCode ^
      thumbnailImage.hashCode ^
      tutor.hashCode ^
      demovideolink.hashCode ^
      search.hashCode ^
      subname.hashCode;

  @override
  String toString() {
    return 'CourseModel{' +
        ' coursename: $coursename,' +
        ' date: $date,' +
        ' listofstudents: $listofstudents,' +
        ' listofvideo: $listofvideo,' +
        ' medium: $medium,' +
        ' showprice: $showprice,' +
        ' ogprice: $ogprice,' +
        ' status: $status,' +
        ' docid: $docid,' +
        ' thumbnailImage: $thumbnailImage,' +
        ' tutor: $tutor,' +
        ' demovideolink: $demovideolink,' +
        ' search: $search,' +
        ' subname: $subname,' +
        '}';
  }

  CourseModel copyWith({
    String? coursename,
    Timestamp? date,
    List<dynamic>? listofstudents,
    List<dynamic>? listofvideo,
    String? medium,
    String? showprice,
    String? ogprice,
    bool? status,
    String? docid,
    String? thumbnailImage,
    String? tutor,
    String? demovideolink,
    List? search,
    String? subname,
  }) {
    return CourseModel(
      coursename: coursename ?? this.coursename,
      date: date ?? this.date,
      listofstudents: listofstudents ?? this.listofstudents,
      listofvideo: listofvideo ?? this.listofvideo,
      medium: medium ?? this.medium,
      showprice: showprice ?? this.showprice,
      ogprice: ogprice ?? this.ogprice,
      status: status ?? this.status,
      docid: docid ?? this.docid,
      thumbnailImage: thumbnailImage ?? this.thumbnailImage,
      tutor: tutor ?? this.tutor,
      demovideolink: demovideolink ?? this.demovideolink,
      search: search ?? this.search,
      subname: subname ?? this.subname,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'coursename': this.coursename,
      'date': this.date,
      'listofstudents': this.listofstudents,
      'listofvideo': this.listofvideo,
      'medium': this.medium,
      'showprice': this.showprice,
      'ogprice': this.ogprice,
      'status': this.status,
      'docid': this.docid,
      'thumbnailImage': this.thumbnailImage,
      'tutor': this.tutor,
      'demovideolink': this.demovideolink,
      'search': this.search,
      'subname': this.subname,
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      coursename: map['coursename'] as String,
      date: map['date'] as Timestamp,
      listofstudents: map['listofstudents'] as List<dynamic>,
      listofvideo: map['listofvideo'] as List<dynamic>,
      medium: map['medium'] as String,
      showprice: map['showprice'] as String,
      ogprice: map['ogprice'] as String,
      status: map['status'] as bool,
      docid: map['docid'] as String,
      thumbnailImage: map['thumbnailImage'] as String,
      tutor: map['tutor'] as String,
      demovideolink: map['demovideolink'] as String,
      search: map['search'] as List,
      subname: map['subname'] as String,
    );
  }

//</editor-fold>
}