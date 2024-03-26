import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hypnohand/model/razorpay_Response.dart';
import '../../../core/constants/firebase_constants.dart';
import '../../../core/constants/providers/firebase_providers.dart';

final SingleCourseRepositoryProvider = Provider((ref) => SingleCourseRepository(
    firestore: ref.read(firestoreProvider),));

class SingleCourseRepository {
  final FirebaseFirestore _firestore;

  SingleCourseRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

CollectionReference get _razorpaySuccess =>
    _firestore.collection(FirebaseConstants.usersCollection);

onPaymentSuccess({required String price,required double discount,required String courseName,required String subName,required Map<dynamic,dynamic>response}){
  RazorPayResponseModel data= RazorPayResponseModel(
      price: price, discount: discount, courseName: courseName, subName: subName, response: response,purchaseDate: DateTime.now()
  );
  _razorpaySuccess.add(data.toMap());
}

}