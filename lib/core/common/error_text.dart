import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String error;
  final String? mess;
  const ErrorText({
    Key? key,
    required this.error,this.mess,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error),
    );
  }
}
