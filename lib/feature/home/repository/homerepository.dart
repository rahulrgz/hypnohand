


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hypnohand/core/constants/providers/firebase_providers.dart';
import 'package:hypnohand/model/announcementmodel.dart';
import 'package:hypnohand/model/courseModel.dart';
import 'package:hypnohand/model/performanceModel.dart';
import 'package:hypnohand/model/reviewmodel.dart';
import 'package:hypnohand/model/settingmodel.dart';
final homeRepositoryProvider=Provider((ref) => HomeRepository(firestore: ref.watch(firestoreProvider)));

class HomeRepository
{///chabnge
  final FirebaseFirestore _firestore;
  HomeRepository({required FirebaseFirestore firestore}):_firestore=firestore;
  CollectionReference get _settings=>_firestore.collection("settings");
  CollectionReference get _performance=>_firestore.collection("performance");
  CollectionReference get _courses=>_firestore.collection("courses");
  CollectionReference get _review=>_firestore.collection("review");
  Future<List<String>> getBanner()async{
    final docshot= await _settings.doc('slider').get();
    return List<String>.from(docshot['sliders']);
    
    
  }
  Stream<SliderSetting>getbanners(){
    // return _firestore.collection("slidersetting").where("delete",isEqualTo: false).snapshots().map((event) => event.docs.map((e) => SliderSetting.fromMap(e.data() as Map<String,dynamic>)).toList());
    
return _firestore.collection("slidersetting").doc("sliderss").snapshots().map((event) => SliderSetting.fromMap(event.data() as Map<String,dynamic>));


  }
  Future<List<PerformanceModel>> getPerformance()async{
    var query=await _performance.where("status",isEqualTo: true).get();

    final a= query.docs.map((e) => PerformanceModel.fromMap(e.data()as Map<String,dynamic>)).toList();
    a.isEmpty?print("empty"):print("notempty");
    print(a[0]);
    return a;
    
    
  }
  Future<List<ReviewModel>>  getReview()async{
    var query=await _review.where("status",isEqualTo: true).get();

    final a= query.docs.map((e) => ReviewModel.fromMap(e.data()as Map<String,dynamic>)).toList();


    return a;


  }
  Future<QuerySnapshot> getPerfromQuery()async{
    return await _performance.where("status",isEqualTo: true).get();
  }
  Future<List<CourseModel>> getCourseList()async{
    final querysnapshot= await _courses.where("status",isEqualTo: true).get();
    return querysnapshot.docs.map((e) => CourseModel.fromMap(e.data() as Map<String,dynamic>)).toList();

  }
  Stream<List<CourseModel>> getcoursesbystream(){
    return _courses.where("status",isEqualTo: true).snapshots().map((event) =>
        event.docs.map((e) => CourseModel.fromMap(e.data() as Map<String,dynamic>)).toList());

  }
  Stream<List<CourseModel>> getcoursebysearch(String name)
  {
    return _courses.where("status",isEqualTo: true).where("search",arrayContains:name.isEmpty ? null : name.toUpperCase(), )
        .orderBy("date", descending: true).snapshots().map((event) =>
        event.docs.map((e) => CourseModel.fromMap(e.data() as Map<String,dynamic>)).toList());
  }
  Future<List<AnnouncementModel>> getAnnounce()async{
   final queryshot= await _firestore.collection("announcement").where("status",isEqualTo: true).orderBy("date",descending: true).get();
   return queryshot.docs.map((e) => AnnouncementModel.fromMap(e.data() as Map<String,dynamic>)).toList();
  }
  


}