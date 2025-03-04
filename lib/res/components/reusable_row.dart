import 'package:covid_tracking/res/color.dart';
import 'package:flutter/material.dart';

class ReusableRow extends StatelessWidget {
  final String title;
  final String value;
  const ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenWidth * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: screenWidth * 0.04, fontFamily: 'Poppins Bold', color: AppColors.titleColor),),
          Text(value, style: TextStyle(fontSize: screenWidth * 0.04, fontFamily: 'Poppins Bold', color: AppColors.subtitleColor),),
        ],
      ),
    );
  }
}
