import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hypnohand/core/global_variables/global_variables.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
  baseColor: Colors.grey.shade300,
  highlightColor: Colors.grey.shade200,
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: w,
      height: h * 0.16,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(),
        color: Colors.grey,
      ),
    ),
  ),
);
  }
}
