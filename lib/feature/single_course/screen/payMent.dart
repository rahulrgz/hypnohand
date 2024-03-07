import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'razor_credentials.dart' as razorCredentials;

class PaymentScreen extends StatefulWidget {
  PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Razorpay _razorpay;
  TextEditingController amtController = TextEditingController();

  void openCheckout(amount) async {
    amount = amount * 100;
    var options = {
      'key': 'rzp_test_s359tMoMl7VfwC',
      'id':"order_${Random().nextInt(100)}",
      'amount': 129900,
      'name': 'Hypno Hands',
      'currency':'INR',
    'description':'course Name',
    'timeout':120,///seconds
      'prefill': {'contact': '6238957201', 'email': 'test@gmail.com'},

      'external': {
        'wallets': ['paytm'],
      },
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void handlePaymentSucces(PaymentSuccessResponse response) {
    ///course purchased...
    Fluttertoast.showToast(
        msg: "payment Successfull " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Failed " + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "External Wallet " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }


  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  void initState() {
    _razorpay = Razorpay();
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
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),

            SizedBox(
              height: 10,
            ),
            Text(
              'Purchase this course for 1299',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            // Padding(
            //   padding: EdgeInsets.all(8.0),
            //   child: TextFormField(
            //     cursorColor: Colors.white,
            //     autofocus: false,
            //     style: TextStyle(color: Colors.white),
            //     decoration: InputDecoration(
            //         labelText: 'enter amount to be paid',
            //         labelStyle: TextStyle(fontSize: 15.0, color: Colors.white)),
            //     controller: amtController,
            //     validator: (value) {
            //       if (value == null || value.isEmpty) {
            //         return 'please enter Amount to be paid';
            //       }
            //     },
            //   ),
            // ),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: () {
    openCheckout(1299);
              },
             child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Make Payement'),
            ))
          ],
        ),
      ),
    );
  }
}
