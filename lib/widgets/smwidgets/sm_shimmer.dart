import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SMShimmer {
  static Widget buildShimmerList() {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var i = 0; i < 10; i++) _buildShimmerItem(),
        ],
      ),
    );
  }

  static Widget _buildShimmerItem() {
    return SizedBox(
      height: 100.0,
      child: Shimmer.fromColors(
          baseColor: Colors.grey[350],
          highlightColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          )),
    );
  }
}
