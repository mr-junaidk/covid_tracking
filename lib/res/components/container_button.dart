import 'package:covid_tracking/res/color.dart';
import 'package:flutter/material.dart';


class ContainerButton extends StatelessWidget {
  final String containerText;
  final VoidCallback onPress;

  const ContainerButton({super.key, required this.containerText, required this.onPress});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onPress,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.recoveredColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: AppColors.titleColor,
                blurRadius: 2,
              )
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: screenWidth * 0.035),
            child: Center(
              child: Text(containerText, style: TextStyle(fontSize: screenWidth * 0.05,
                  fontFamily: 'Poppins Medium',
                  color: AppColors.titleColor),),
            ),
          ),
        ),
      ),
    );
  }
}



