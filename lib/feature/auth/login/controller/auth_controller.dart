import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hypnohand/core/failure.dart';
import 'package:hypnohand/core/utils.dart';
import 'package:hypnohand/feature/auth/login/repository/auth_repository.dart';
import 'package:hypnohand/feature/auth/login/screen/google_apple_signin.dart';
import 'package:hypnohand/feature/home/screen/bottom_nav.dart';
import 'package:hypnohand/feature/home/screen/home_screen.dart';
import 'package:hypnohand/feature/profile/screen/profile_screen.dart';
import 'package:hypnohand/main.dart';
import 'package:hypnohand/model/usermodel.dart';

final userProvier = StateProvider<UserModel?>((ref) => null);
final loginPlaystorebool=StreamProvider((ref) => ref.watch(authControllerProvider.notifier).loginplaystorebool());
final getPlayStoreStream=StreamProvider((ref) => ref.watch(authControllerProvider.notifier).playstorebool());
final authControllerProvider = StateNotifierProvider<AuthController, bool>(
    (ref) => AuthController(
        authRepository: ref.watch(authRepositoryProvider), ref: ref));

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authcontroller = ref.watch(authControllerProvider.notifier);
  return  authcontroller.getUserData(uid);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);

  Stream<User?> get authStateChange => _authRepository.authStateChange;
  Stream<bool?> playstorebool(){
    return _authRepository.getPlaystorebool();
  }
  Stream<bool?> loginplaystorebool(){
    return _authRepository.getloginPlaystorebool();
  }
///chabnge
  void signInWithGoogle({
    required WidgetRef ref,
    String? name,
    String? profileUrl,
    List? search,
    String? id,
    String? phone,
    String? email,
    String? photoUrl,
    String? gstNo,
    int? status,
    Map<String, dynamic>? bankDetails,
    String? companyDescription,
    List? brandList,
    List? categoryList,
    List? companyDetails,
    String? document,
    DateTime? date,
    int? displayStatus,
    String? freeshippingAmount,
    String? sellerWiseFlatRateShipping,
    String? flatRateAmount,
    bool? cashOnDelivery,
    String? orderReturnAge,
    String? orderCancellationAge,
    String? shipmentTime,
    String? invoiceNumber,
    String? logo,
    List? productList,
    String? signature,
    String? bannerVideo,
    String? bannerImage,
    String? paymentPolicy,
    DateTime? resetInvoiceNumber,
    String? deliveryPolicy,
    required BuildContext context,
  }) async {
    state = true;
    final user =
        await _authRepository.singInwithGoogle(context: context, ref: ref);
    state = false;
    user.fold(
      (l) {
        print(l.message);
        showSnackbar(context, l.message);
      },
      (r) async {
        if (r == null) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return GoogleApplesignin();
          }));
        } else {
          prefs!.setBool('logged', true);
          //  ref.read(signUpOtpverified.notifier).update((state) => false);

          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (context) {
              return const BottomNav();
            },
          ), (route) => false);
        }

        return _ref.read(userProvider.notifier).update((state) => r);
      },
    );
  }

  getUser() {
    _authRepository.getUser();
  }

  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  upDateGoogleSignInDoc(
      {String? name,
      String? profileUrl,
      List? search,
      String? id,
      String? phone,
      String? email,
      String? photoUrl,
      String? gstNo,
      int? status,
      Map<String, dynamic>? bankDetails,
      String? companyDescription,
      List? brandList,
      List? categoryList,
      List? companyDetails,
      DateTime? date,
      int? displayStatus,
      String? freeshippingAmount,
      String? sellerWiseFlatRateShipping,
      String? flatRateAmount,
      bool? cashOnDelivery,
      String? orderReturnAge,
      String? orderCancellationAge,
      String? shipmentTime,
      String? invoiceNumber,
      String? logo,
      List? productList,
      String? signature,
      String? bannerVideo,
      String? bannerImage,
      String? paymentPolicy,
      DateTime? resetInvoiceNumber,
      String? deliveryPolicy,
      String? state,
      String? country,
      required WidgetRef ref,
      required BuildContext context}) async {
    final user = await _authRepository.updateGoogleSignInDoc(
        state: state ?? '',
        country: country ?? '',
        phone: phone ?? '',
        name: name ?? '');

    user.fold((l) {
      showSnackbar(context, l.message);
    }, (r) async {
      await prefs?.setBool('logged', true);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
        return BottomNav();
      }), (route) => false);
    });
  }

  void logOut({required BuildContext context}) async {
    try {
      _authRepository.logOut(context: context);
      prefs!.setBool('logged', false);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  signInWithEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context,
      required WidgetRef ref}) async {
    final res = await _authRepository.signInWithEmailAndPassword(
        email: email, password: password, context: context, ref: ref);

    // res.fold(
    //   (l) => Failure(l.message),
    //   (r) {
    //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
    //       builder: (context) {
    //         return BottomNav();
    //       },
    //     ), (route) => false);

    //     prefs!.setBool('logged', true);
    //   },
    // );
  }

  createUserWithEmailAndPassword({
    required String name,
    required String email,
    required String number,
    required String password,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final res = await _authRepository.createUserWithEmailAndPassword(
        email: email, password: password, number: number, name: name);
    res.fold((l) {
      showSnackbar(context, l.message);
      // ref.read(signUpOtpverified.notifier).update((state) => false);
    }, (r) async {
      // ref.read(signUpOtpverified.notifier).update((state) => false);
      prefs!.setBool('logged', true);
      userModel = (await _authRepository.getUser());
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return const BottomNav();
      }));
    });
  }

//   otpCheckUser({required String phone,required String email , required BuildContext context})async{
//     var res=await _authRepository.otpcheckUser(phone: phone,email: email);
//     res.fold((l) => showSnackbar(context,l.message),
//             (r){
//       if(r==null){
//         Navigator.of(context)
//             .pushReplacement(MaterialPageRoute(builder: (context) {
//           return
//             Profilepage1(signInType: ActionTionType.otpSignIn,phoneNumber: phone,);
//         }));
//       }
//    else{
//        _ref.read(userProvier.notifier).update((state) => r);
//        prefs.setBool('logged', true);
//         Navigator.of(context)
//             .pushReplacement(MaterialPageRoute(builder: (context) {
//           return const HomePage();
//         }));
//       }
//     });
//   }

//  otpCreateUser({required String name,required String phone,required BuildContext context,required String state,required String country,required String email})async{
//       var res=await _authRepository.otpCreateUser(name: name,phone: phone,state: state,country: country, email: email);
//       res.fold((l) => showSnackbar(context,l.message), (r)async {
//         prefs.setBool('logged', true);
//         Navigator.of(context)
//             .pushAndRemoveUntil(MaterialPageRoute(builder: (context){
//               return HomePage();
//         }), (route) => false);
//       });
//   }
}
