import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hypnohand/core/constants/providers/firebase_providers.dart';
import 'package:hypnohand/core/model/performanceModel.dart';
final homeRepositoryProvider=Provider((ref) => HomeRepository(firestore: ref.watch(firestoreProvider)));

class HomeRepository
{
  final FirebaseFirestore _firestore;
  HomeRepository({required FirebaseFirestore firestore}):_firestore=firestore;
  CollectionReference get _settings=>_firestore.collection("settings");
  CollectionReference get _performance=>_firestore.collection("performance");
  Future<List<String>> getBanner()async{
    final docshot= await _settings.doc('slider').get();
    return List<String>.from(docshot['sliders']);
    
    
  }
  Future<List<PerformanceModel>> getPerformance()async{
    var query=await _performance.where("status",isEqualTo: true).get();

    final a= query.docs.map((e) => PerformanceModel.fromMap(e.data()as Map<String,dynamic>)).toList();
    a.isEmpty?print("empty"):print("notempty");
    print(a[0]);
    return a;
    
    
  }
  Future<QuerySnapshot> getPerfromQuery()async{
    return await _performance.where("status",isEqualTo: true).get();
  }
  
  


}