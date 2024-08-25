import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hypnohand/core/utils.dart';
import 'package:hypnohand/model/courseModel.dart';
import 'package:hypnohand/model/usermodel.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../core/constants/firebase_constants.dart';
import '../../../model/razorpay_Response.dart';
import 'razor_credentials.dart' as razorCredentials;
import 'package:http/http.dart' as http;

class PaymentScreen extends ConsumerStatefulWidget {
  final CourseModel data;
  PaymentScreen({required this.data});

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  late Razorpay _razorpay;
  final paymentStatusProvider = StateProvider((ref) => 'Not Initiated');

  CollectionReference get _razorpaySuccess =>
      FirebaseFirestore.instance.collection(FirebaseConstants.razorpaySuccess);

  CollectionReference get _courses =>
      FirebaseFirestore.instance.collection(FirebaseConstants.courses);

  TextEditingController amtController = TextEditingController();
  String? coursePrice;
  String? username;
  String? coursename;
  String? docidcourse;

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSucces);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
    coursePrice =widget.data.ogprice+'00';
    username=userModel!.name;
    coursename=widget.data.coursename;
    docidcourse=widget.data.docid;
    super.initState();
  }

  onPaymentSuccess(
      {required String price,
      required double discount,
      required String courseName,
        required String docidcourse,
      required String subName,
      required Map<dynamic, dynamic> response}) {
    print(price);
    print('ente price------------');
    RazorPayResponseModel data = RazorPayResponseModel(
      docidcourse: docidcourse,
        price: price,
        discount: discount,
        courseName: courseName,
        subName: subName,
        response: response,
        purchaseDate: DateTime.now());
    _razorpaySuccess.add(data.toMap());

    List _newStudentList = widget.data.listofstudents;
    _newStudentList.add(userModel!.id!);
    print(_newStudentList);
    print('new list----------');

    CourseModel _courseUpdateData =
        coursemodell!.copyWith(listofstudents: _newStudentList);

    _courses
        .doc(widget.data.docid)
        .update(_courseUpdateData.toMap())
        .then((value) {
      showSnackbar(context, 'Courses are now unlocked');
    });
  }

  // create order
  void createOrder() async {
    String username =
        razorCredentials.keyId; //key id you get from razorpay from settings
    String password = razorCredentials.keySecret; //this tooo
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}'; //this api required basic auth user and pass.

    Map<String, dynamic> body = {
      "amount": coursePrice,
      "currency": "INR",
      "receipt": "rcptid_11"
    };

    var res = await http.post(
      Uri.https(
          "api.razorpay.com", "v1/orders"), //https://api.razorpay.com/v1/orders
      headers: <String, String>{
        "Content-Type": "application/json",
        'authorization': basicAuth,
      },
      body: jsonEncode(body),
    );
    print(res.statusCode);
    print("res.statusCode----------");
    if (res.statusCode == 200) {
      ///on success move to second step checkout.
      ///in response on create order id pass it to checkout.
      openGateway(jsonDecode(res.body)['id']);
    }
    print(res.body);
  }

  openGateway(String orderId) {
    print(coursePrice);
    print("funda price===========");
    var options = {
      'key': razorCredentials.keyId,

      ///key id from razorpay
      'amount': coursePrice! ,

      ///in the smallest currency sub-unit.
      'name': 'Hypno Hand.',
      'order_id': orderId,

      /// Generate order_id using Orders API

      'description': 'Course 1  ',
      'timeout': 60 * 5,

      /// in seconds // 5 minutes

      'prefill': {
        'contact': userModel?.phoneNumber??'',
        'email': userModel?.email??'',
      },
      'external': {
        'wallets': ['paytm']
      },
    };
    _razorpay.open(options);

    ///open gateway for checkout
    ///now to check responses thats success or failed etc , you will get those in listener.
  }

  void handlePaymentSucces(PaymentSuccessResponse response) {
    ref
        .read(paymentStatusProvider.notifier)
        .update((state) => 'Payment Successfull');
    onPaymentSuccess(
        price: coursePrice??'' ,
        discount: 0,
        courseName: coursename??"null",
        subName:username??"null",
        response: {}, docidcourse: docidcourse ?? "null");
    print(response.signature);
    print(response.paymentId);
    print(response.orderId);
    // print(response.data);

    print("success response-------------");

    ///on success we will verify signature to check authenticity

    verifySignature(
      orderId: response.orderId,
      paymentId: response.paymentId,
      signature: response.signature,
    );

    ///course purchased...
    Fluttertoast.showToast(
      msg: "payment Successfull " + response.paymentId!,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void handlePaymentError(PaymentFailureResponse response) {
    ref
        .read(paymentStatusProvider.notifier)
        .update((state) => 'Payment Failed');
    print(response);
    print(response.message);
    // print(response.error);
    print(response.code);

    print('failure response----------------------');

    Fluttertoast.showToast(
        msg: "Payment Failed " + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    print(response);
    print('external wallet response--------------');
    Fluttertoast.showToast(
        msg: "External Wallet " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

  ///i hv written php code on server side to verify signature.
  ///below fuction is to call the api.
  verifySignature({
    String? signature,
    String? paymentId,
    String? orderId,
  }) async {
    ///here we are calling post request url encoded
    Map<String, dynamic> body = {
      'razorpay_signature': signature,
      'razorpay_payment_id': paymentId,
      'razorpay_order_id': orderId,
    };

    var parts = [];
    body.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value)}');
    });
    var formData = parts.join('&');
    var res = await http.post(
      Uri.https(
        "10.0.2.2", // my ip address , localhost
        "razorpay_signature_verify.php",
      ),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded", // urlencoded
      },
      body: formData,
    );

    print(res.body);
    if (res.statusCode == 200) {
      print("payment Verified--");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.body),

          ///we are showing response from signature verification api
        ),
      );
    }
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Purchase this course for 1,299',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    createOrder();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Make Payement'),
                  )),
              SizedBox(
                height: 30,
              ),
              Consumer(
                builder: (context, ref, child) {
                  return Text(
                    "Payment Status: ${ref.watch(paymentStatusProvider)},",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
