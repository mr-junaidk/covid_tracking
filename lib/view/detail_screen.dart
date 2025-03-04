import 'package:covid_tracking/res/color.dart';
import 'package:covid_tracking/res/components/reusable_row.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int totalCases, totalDeaths, totalRecovered, active, critical, todayRecovered, test;

  DetailScreen({super.key,
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.darkGradient,
                AppColors.lightGradient,
              ],
              stops: [0.0, 1.0],
              transform: GradientRotation(135 * math.pi / 180),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenWidth * 0.04),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back_ios_new, size: screenWidth * 0.06, color: AppColors.titleColor,)),
                      SizedBox(width: screenWidth * 0.06,),
                      Flexible(child: Text(widget.name.toUpperCase(), style: TextStyle(fontSize: screenWidth * 0.05, fontFamily: 'Poppins Bold', color: AppColors.titleColor),))
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.15,),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: screenWidth * 0.13),
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenWidth * 0.02),
                          child: Column(
                            children: [
                              SizedBox(height: screenHeight * 0.06,),
                              ReusableRow(title: 'Total Cases', value: widget.totalCases.toString()),
                              Divider(color: AppColors.dividerColor,),
                              ReusableRow(title: 'Total Deaths', value: widget.totalDeaths.toString()),
                              Divider(color: AppColors.dividerColor,),
                              ReusableRow(title: 'Total Recovered', value: widget.totalRecovered.toString()),
                              Divider(color: AppColors.dividerColor,),
                              ReusableRow(title: 'Active Cases', value: widget.active.toString()),
                              Divider(color: AppColors.dividerColor,),
                              ReusableRow(title: 'Critical Cases', value: widget.critical.toString()),
                              Divider(color: AppColors.dividerColor,),
                              ReusableRow(title: 'Total Test', value: widget.test.toString()),
                              Divider(color: AppColors.dividerColor,),
                              ReusableRow(title: 'Today Recovered', value: widget.todayRecovered.toString()),

                            ],
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: screenWidth * 0.12,
                      backgroundImage: NetworkImage(widget.image),
                    )
                  ],
                )
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
