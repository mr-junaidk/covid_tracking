import 'package:covid_tracking/models/WorldStatesModel.dart';
import 'package:covid_tracking/res/color.dart';
import 'package:covid_tracking/res/components/container_button.dart';
import 'package:covid_tracking/res/components/reusable_row.dart';
import 'package:covid_tracking/services/states_services.dart';
import 'package:covid_tracking/view/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'dart:math' as math;

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates> with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,)..repeat();

  @override
  void dipose(){
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color> [
    AppColors.totalColor,
    AppColors.recoveredColor,
    AppColors.deathsColor,
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
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
                  SizedBox(height: screenHeight * 0.01),
                  FutureBuilder<WorldStatesModel>(
                      future: statesServices.fetchWorldStatesRecords(),
                      builder: (context, AsyncSnapshot<WorldStatesModel> snapshot){
                        if(!snapshot.hasData){
                          return Expanded(
                              flex: 1,
                              child: SpinKitFadingCircle(
                                color: AppColors.whiteColor,
                                size: 50,
                                controller: _controller,
                              )
                          );
                        }else{
                          return Expanded(
                            child: Column(
                              children: [
                                PieChart(
                                  dataMap: {
                                    "Total": double.parse(snapshot.data!.cases!.toString()),
                                    "Recovered": double.parse(snapshot.data!.recovered!.toString()),
                                    "Deaths": double.parse(snapshot.data!.deaths!.toString())
                                  },
                                  chartValuesOptions: const ChartValuesOptions(
                                    showChartValuesInPercentage: true
                                  ),
                                  chartRadius: screenWidth / 1.5,
                                  legendOptions: const LegendOptions(
                                      legendPosition: LegendPosition.left
                                  ),
                                  animationDuration: const Duration(microseconds: 1200),
                                  chartType: ChartType.ring,
                                  colorList: colorList,
                                ),
                                SizedBox(height: screenHeight * 0.04,),
                                Card(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenWidth * 0.02),
                                    child: Column(
                                      children: [
                                        ReusableRow(title: 'Total', value: snapshot.data!.cases.toString()),
                                        Divider(color: AppColors.dividerColor,),
                                        ReusableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                                        Divider(color: AppColors.dividerColor,),
                                        ReusableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                        Divider(color: AppColors.dividerColor,),
                                        ReusableRow(title: 'Active', value: snapshot.data!.active.toString()),
                                        Divider(color: AppColors.dividerColor,),
                                        ReusableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                                        Divider(color: AppColors.dividerColor,),
                                        ReusableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                                        Divider(color: AppColors.dividerColor,),
                                        ReusableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),

                                      ],
                                    ),
                                  ),
                                ),
                                Spacer(),
                                ContainerButton(
                                    containerText: 'Track Countries',
                                    onPress: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => CountriesListScreen()));
                                    }
                                ),
                              ],
                            ),
                          );
                        }
                      }
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}


