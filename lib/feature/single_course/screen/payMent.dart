import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../core/constants/firebase_constants.dart';
import '../../../model/razorpay_Response.dart';
import 'razor_credentials.dart' as razorCredentials;
import 'package:http/http.dart'as http;

class PaymentScreen extends ConsumerStatefulWidget {
  PaymentScreen({super.key});

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  CollectionReference get _razorpaySuccess =>
      FirebaseFirestore.instance.collection(FirebaseConstants.razorpaySuccess);

  onPaymentSuccess({required double price,required double discount,required String courseName,required String subName,required Map<dynamic,dynamic>response}){
    RazorPayResponseModel data= RazorPayResponseModel(
        price: price, discount: discount, courseName: courseName, subName: subName, response: response,purchaseDate: DateTime.now()
    );
    _razorpaySuccess.add(data.toMap());
  }

  final paymentStatusProvider=StateProvider((ref) => 'Not Initiated');

  final _razorpay =Razorpay();
  TextEditingController amtController = TextEditingController();

  // create order
  void createOrder() async {
    String username = razorCredentials.keyId;//key id you get from razorpay from settings
    String password = razorCredentials.keySecret;//this tooo
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';//this api required basic auth user and pass.

    Map<String, dynamic> body = {
      "amount": 100,
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

    if (res.statusCode == 200) {
      ///on success move to second step checkout.
      ///in response on create order id pass it to checkout.
      openGateway(jsonDecode(res.body)['id']);
    }
    print(res.body);
  }

  openGateway(String orderId) {
    var options = {
      'key': razorCredentials.keyId,///key id from razorpay
      'amount': 100, ///in the smallest currency sub-unit.
      'name': 'Hypno Hand.',
      'order_id': orderId, /// Generate order_id using Orders API
      'description': 'Course 1  ',
      'timeout': 60 * 5, /// in seconds // 5 minutes
      'prefill': {
        'contact': '9123456789',
        'email': 'hypnosupport@example.com',
      }
    };
    _razorpay.open(options);///open gateway for checkout
    ///now to check responses thats success or failed etc , you will get those in listener.
  }

  void handlePaymentSucces(PaymentSuccessResponse response) {
      ref.read(paymentStatusProvider.notifier).update((state) => 'Payment Successfull');
      onPaymentSuccess(price: 1299, discount: 0, courseName: 'course 1', subName: 'course 1', response: {});
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
        ref.read(paymentStatusProvider.notifier).update((state) => 'Payment Failed');
        print( response);
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.body),///we are showing response from signature verification api
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
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSucces);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
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
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),

              SizedBox(height: 30,),
              ElevatedButton(onPressed: () {
              createOrder();
                },
               child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Make Payement'),
              )),
              Consumer(builder: (context, ref, child) {
                return Text("Payment Status: ${ref.watch(paymentStatusProvider)},",style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),);
              },
              )
            ],
          ),
        ),
      ),
    );
  }
}