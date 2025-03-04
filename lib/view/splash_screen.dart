import 'dart:async';
import 'package:covid_tracking/res/color.dart';
import 'package:covid_tracking/view/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();

  @override

  void dipose(){
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(
      const Duration(seconds: 5),
          () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => WorldStates())),
    );
  }

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
          child: Stack(
            fit: StackFit.expand,
            children: [
              Opacity(
                opacity: 0.1,
                child: Image.asset(
                  'assets/images/virus.png',
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    child: Center(
                      child: Image.asset('assets/images/virus.png'),
                    ),
                    builder: (BuildContext context, Widget? child) {
                      return Transform.rotate(
                        angle: _controller.value * 2.8 * math.pi,
                        child: child,
                      );
                    },
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Covid-19\nTracker App',
                      style: TextStyle(
                          fontSize: screenWidth * 0.1, fontFamily: 'Sofia Pro', color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


