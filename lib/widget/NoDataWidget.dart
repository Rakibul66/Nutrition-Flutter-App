import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
              'assets/no_data.json',
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'No data available',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}