import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hypnohand/core/constants/firebase_constants.dart';
import 'package:hypnohand/core/constants/providers/firebase_providers.dart';
import 'package:hypnohand/core/failure.dart';
import 'package:hypnohand/core/type_def.dart';
import 'package:hypnohand/feature/auth/login/screen/login.dart';
import 'package:hypnohand/main.dart';
import 'package:hypnohand/model/usermodel.dart';


final userProvider = StateProvider<UserModel?>((ref) => null);

final authRepositoryProvider = Provider((ref) => AuthRepository(
    firestore: ref.read(firestoreProvider),
    firebaseAuth: ref.read(authProvider),
    googleSignIn: ref.read(googleSignInProvider)));

String? currentUserId;
var currentUserName;
UserCredential? userCredential;

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepository(
      {required FirebaseFirestore firestore,
      required FirebaseAuth firebaseAuth,
      required GoogleSignIn googleSignIn})
      : _firestore = firestore,
        _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;

  FutureEither<UserModel?> singInwithGoogle(
      {
        String? name,
        String? phoneNumber,
        required BuildContext context,
      }) async {
    try {

      final GoogleSignInAccount? existingUser = await _googleSignIn.signInSilently();
    if (existingUser != null) {
      await _googleSignIn.signOut();
    }

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // If the user cancels the Google Sign-In process, googleUser will be null.
      if (googleUser == null) {
        await _googleSignIn.signOut();
        // Handle the case where the user cancels the sign-in process.
        return left(Failure('Google Sign-In canceled.'));
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      userCredential = await _firebaseAuth.signInWithCredential(credential);
      print(credential);

      currentUserName = userCredential?.user!.displayName;
      currentUserId = userCredential?.user!.uid;

      if (userCredential!.additionalUserInfo!.isNewUser) {
print("New User============================");


userModel = UserModel(
  name: name??'',
  phoneNumber: phoneNumber??'',
  email: userCredential!.user!.email.toString()
        );

        DocumentReference documentReference= _users.doc(userCredential!.user!.uid);

        documentReference.set(userModel!.toJson()).then((value) {
          userModel=userModel?.copyWith(reference: documentReference,id:documentReference.id);
          documentReference.update(userModel!.toJson());
          prefs!.setString('currentuserId', documentReference.id);

        });
        return right(null);
      }
      else {
        userModel = (await getUser());
        if(userModel?.name!=null && userModel?.phoneNumber !=null && userModel?.name!='' && userModel?.phoneNumber !='' ){
          print(userModel?.id);
          print("old User============================");
          print(userModel?.name);
          print(userModel?.phoneNumber);
          print(userCredential?.user?.email);
          print(userCredential?.user?.photoURL);

          print('$userModel aaaaaaaaaaaaaaaaaa');
          prefs!.setString('currentuserId', userModel!.id.toString());

          return right(userModel);
        }else{
          return right(null);
        }
      }
    } on FirebaseException catch (e) {
      throw 'firebase exception';
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

    Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map(
        (event) => UserModel.fromJson(event.data() as Map<String, dynamic>));
  }
  
  Future<UserModel?> getUser() async {

    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection(FirebaseConstants.usersCollection)
        .doc(currentUserId)
        .get();
    print(snapshot.exists);
    if (snapshot.exists) {
      final data = UserModel.fromJson(snapshot.data()!);
      userModel=data;
      return data;
    }
    return null;

  }

    void logOut({required BuildContext context}) async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
      return LoginScreen();
    }), (route) => false);
  }

  
  FutureEither<UserModel?> updateGoogleSignInDoc({
    required String name,required String phone,required String country,required String state
  }) async {
    try {
      var user=await _users.where('phone',isEqualTo: phone).get();
      if(user.docs.isNotEmpty){
       return left(Failure('phone Number already exists'));
      }else{
              var data=userModel?.copyWith(name: name,phoneNumber: phone,);

      userModel?.ref?.update(data!.toJson());

      userModel = (await getUser());

      // print("${userModel!.Fullname}==========================update google sign in");

      return right(userModel);
      }

    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // FutureEither<UserModel?> signInWithEmailAndPassword(
  //     {required String phone, required String email}) async {
  //   try {
  //     final user = await _firestore
  //         .collection(FirebaseConstants.usersCollection)
  //         .where('email', isEqualTo: email)
  //         .get();
  //
  //     if (user.docs.isEmpty) {
  //       return right(null);
  //     } else {
  //       userModel = UserModel.fromJson(user.docs.first.data());
  //       return right(userModel);
  //     }
  //   } catch (e) {
  //     return left(Failure(e.toString()));
  //   }
  // }

//    signInWithEmailAndPassword(
//       {required String password, required String email,required BuildContext context}) async {
//     try {
//       final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: email,
//           password: password
//       ).then((value) async{
//         final user = await _firestore
//                 .collection(FirebaseConstants.usersCollection)
//                 .where('email', isEqualTo: email)
//                 .get();
//         userModel = UserModel.fromJson(user.docs.first.data());
// print("heloooooooooooooooooooooooooooooooooooooooooooooooooo");
//         Navigator.push(
//           context,
//           CupertinoPageRoute(
//             builder: (context) => const HomePage(),
//           ),
//         );
//         prefs.setBool('logged', true);
//       });
//     } catch(e){
//       showSnackbar(context, e.toString());
//     }
//   }

//   Future<Either<Failure, dynamic>> createUserWithEmailAndPassword({
//     required String name,
//     required String email,
//     required String password,
//     required String number,
//     required String state,
//     required String country,
//   }) async {
//     try {

//      var user=await _users.where('phone',isEqualTo: number).get();

//      if(user.docs.isNotEmpty){
//       return left(Failure('phone Number already exists..try another'));
//      }else{
//       var model = UserModel(
//         Fullname: name,
//         profileUrl: '',
//         search: [],
//         id: '',
//         phone: number,
//         email: email,
//         photoUrl: '',
//         gstNo: '',
//         status: 0,
//         bankdetails: {},
//         companyDescription: '',
//         brandList: [],
//         categoryList: [],
//         companyDetails: [],
//         date: DateTime.now(),
//         displayStatus: 0,
//         freeshippingAmount: '',
//         sellerWiseFlatRateShipping: '',
//         flatRateAmount: '',
//         cashOnDelivery: false,
//         orderReturnAge: '',
//         orderCancellationAge: '',
//         shipmentTime: '',
//         invoiceNumber: '',
//         logo: '',
//         productList: [],
//         signature: '',
//         bannerVideo: '',
//         bannerImage: '',
//         paymentPolicy: '',
//         resetInvoiceNumber: DateTime.now(),
//         deliveryPolicy: '',
//         state: state,
//         country: country,
//         pinCode: '',
//       );

//       var res = await _firebaseAuth
//           .createUserWithEmailAndPassword(email: email, password: password)
//           .then((value) {
//         ///add data to firebase;

//         _firestore
//             .collection(FirebaseConstants.usersCollection)
//             .add(model.toJson())
//             .then((value) async {
//           var _res = await value.get();
//           var data = model.copyWith(id: _res.id, date: DateTime.now(),ref: _res.reference);
//           _users.doc(data.id).update(data.toJson());

//           currentUserId = _res.id;
//           prefs.setString('currentuserId', currentUserId!);
//           prefs.setBool('logged', true);
//           userModel = (await getUser());
//           print("currentUserId");
//           print(currentUserId);
//           print("currentUserId prefs");
//           print(prefs.getString('currentuserId'));
//           print('==============================');
//         });
//       });

//       return right(res);
//      }


      
//     } catch (e) {
//       return left(Failure(e.toString()));
//     }
//   }

//   FutureEither<UserModel?> otpcheckUser(
//       {required String phone, required String email}) async {
//     try {
//       final user = await _firestore
//           .collection(FirebaseConstants.usersCollection)
//           .where('phone', isEqualTo: phone)
//           .get();

//       if (user.docs.isEmpty) {
//         return right(null);
//       } else {
//         userModel = UserModel.fromJson(user.docs.first.data());
//         return right(userModel);
//       }
//     } catch (e) {
//       return left(Failure(e.toString()));
//     }
//   }

//   FutureEither<UserModel> otpCreateUser({
//     required String name,
//     required String phone,
//     required String state,
//     required String country,
//     required String email,
//   }) async {
//     try {

      

//       userModel = UserModel(
//         Fullname: name,
//         profileUrl: '',
//         search: [],
//         id: '',
//         phone: phone,
//         email: email,
//         photoUrl: '',
//         gstNo: '',
//         status: 0,
//         bankdetails: {},
//         companyDescription: '',
//         brandList: [],
//         categoryList: [],
//         companyDetails: [],
//         date: DateTime.now(),
//         displayStatus: 0,
//         freeshippingAmount: '',
//         sellerWiseFlatRateShipping: '',
//         flatRateAmount: '',
//         cashOnDelivery: false,
//         orderReturnAge: '',
//         orderCancellationAge: '',
//         shipmentTime: '',
//         invoiceNumber: '',
//         logo: '',
//         productList: [],
//         signature: '',
//         bannerVideo: '',
//         bannerImage: '',
//         paymentPolicy: '',
//         resetInvoiceNumber: DateTime.now(),
//         deliveryPolicy: '',
//         state: state,
//         country: country,
//         pinCode: '',
//       );

//       _firestore
//           .collection(FirebaseConstants.usersCollection)
//           .add(userModel!.toJson())
//           .then(
//         (value) async {
//           var _res = await value.get();
//           var data = userModel!.copyWith(id: _res.id,ref: _res.reference);
//           _users.doc(data.id).update(data.toJson());
//           currentUserId = _res.id;
//           prefs.setBool('logged', true);
//           prefs.setString('currentuserId', currentUserId!);
//           userModel = (await getUser());
//           print("currentUserId");
//           print(currentUserId);
//           print("currentUserId prefs");
//           print(prefs.getString('currentuserId'));
//           print('==============================');
//         },
//       );

//       return right(userModel!);
//     } catch (e) {
//       return left(Failure(e.toString()));
//     }
//   }

//   Stream<UserModel> getUserData(String uid) {
//     return _users.doc(uid).snapshots().map(
//         (event) => UserModel.fromJson(event.data() as Map<String, dynamic>));
//   }

  
// //  FutureEither checkPhoneNumberExists({required String phone})async{
// //     try{
// //       var user = await _users.where('phone', isEqualTo: phone).get();

// //       if (user.docs.isEmpty) {
// //         return right('number not found');
// //       } else {
// //         return left(Failure('number found'));
// //       }
// //     }catch(e){
// //       return left(Failure(e.toString()));
// //     }
// //   }


}
