import 'package:covid_tracking/res/color.dart';
import 'package:covid_tracking/services/states_services.dart';
import 'package:covid_tracking/view/detail_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose(){
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

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
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios_new, size: screenWidth * 0.06, color: AppColors.titleColor,)),
                ),
                SizedBox(height: screenHeight * 0.06,),
                TextFormField(
                  controller: searchController,
                  onChanged: (value){
                    setState(() {
                      
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    hintText: 'Search with country name',
                    hintStyle: TextStyle(fontSize: screenWidth * 0.04, fontFamily: 'Poppins Medium', color: AppColors.subtitleColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02,),
                FutureBuilder(
                  future: statesServices.fetchCountries(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
                    if(!snapshot.hasData){
                      return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index){
                              return Shimmer.fromColors(
                                  baseColor: AppColors.darkGradient,
                                  highlightColor: AppColors.lightGradient,
                                  child: ListTile(
                                    title: Container(height: screenWidth * 0.03, width: screenWidth * 0.22, color: Colors.white,),
                                    subtitle: Container(height: screenWidth * 0.03, width: screenWidth * 0.22, color: Colors.white,),
                                    leading: Container(height: screenWidth * 0.12, width: screenWidth * 0.12, color: Colors.white,),
                                  ),
                              );
                            }),
                      );
                    }else{
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                            itemBuilder: (context, index){
                            String name = snapshot.data![index]['country'];

                            if(searchController.text.isEmpty){
                              return InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                                    name: snapshot.data![index]['country'],
                                    image: snapshot.data![index]['countryInfo']['flag'],
                                    totalCases: snapshot.data![index]['cases'],
                                    totalDeaths: snapshot.data![index]['deaths'],
                                    totalRecovered: snapshot.data![index]['recovered'],
                                    active: snapshot.data![index]['active'],
                                    critical: snapshot.data![index]['critical'],
                                    todayRecovered: snapshot.data![index]['todayRecovered'],
                                    test: snapshot.data![index]['tests'],)));
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country'], style: TextStyle(fontSize: screenWidth * 0.04, fontFamily: 'Poppins Medium', color: AppColors.titleColor),),
                                  subtitle: Text(snapshot.data![index]['cases'].toString(), style: TextStyle(fontSize: screenWidth * 0.04, fontFamily: 'Poppins Medium', color: AppColors.subtitleColor),),
                                  leading: Image(
                                      height: screenWidth * 0.12,
                                      width: screenWidth * 0.12,
                                      image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])),
                                ),
                              );
                            }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                              return InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                                    name: snapshot.data![index]['country'],
                                    image: snapshot.data![index]['countryInfo']['flag'],
                                    totalCases: snapshot.data![index]['cases'],
                                    totalDeaths: snapshot.data![index]['deaths'],
                                    totalRecovered: snapshot.data![index]['recovered'],
                                    active: snapshot.data![index]['active'],
                                    critical: snapshot.data![index]['critical'],
                                    todayRecovered: snapshot.data![index]['todayRecovered'],
                                    test: snapshot.data![index]['tests'],)));
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country'], style: TextStyle(fontSize: screenWidth * 0.04, fontFamily: 'Poppins Medium', color: AppColors.titleColor),),
                                  subtitle: Text(snapshot.data![index]['cases'].toString(), style: TextStyle(fontSize: screenWidth * 0.04, fontFamily: 'Poppins Medium', color: AppColors.subtitleColor),),
                                  leading: Image(
                                      height: screenWidth * 0.12,
                                      width: screenWidth * 0.12,
                                      image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])),
                                ),
                              );
                            }else{
                              return Container();
                            }
                        }),
                      );
                    }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
