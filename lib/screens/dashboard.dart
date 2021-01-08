import 'package:flutter/material.dart';
import 'package:foodly/constants/theme_constants.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var data;
  var bmi;
  bool isDataSet = false;
  @override
  void initState() {
    super.initState();
    restore();
  }

  restore() async {
    final pref = await SharedPreferences.getInstance();
    final extractedUserData =
        json.decode(pref.getString('userData')) as Map<String, Object>;

    setState(() {
      data = extractedUserData ?? false;
      bmi = double.parse(extractedUserData['weight']) /
          ((double.parse(extractedUserData['height']) * 0.3048) *
              (double.parse(extractedUserData['height']) * 0.3048));
      isDataSet = true;
    });
  }

  Widget build(BuildContext context) {
    final percentage = 0;
    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: kIndigoColor,
                height: 60,
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Dashboard',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    Icon(
                      Icons.search,
                      size: 24.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: isDataSet
                      ? Text('Welcome, ' + data['name'],
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ))
                      : Text('Welcome,',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ))),
              SizedBox(height: 15),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                      color: kIndigoColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Eaten', style: kTitle3Style),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Image.asset(
                                'assets/eaten.png',
                                height: 20,
                                width: 20,
                              ),
                              SizedBox(width: 5),
                              Text('0', style: kTitle4Style),
                              SizedBox(width: 3),
                              Text('kcal', style: kTitle3Style),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text('Burned', style: kTitle3Style),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Image.asset(
                                'assets/burned.png',
                                height: 20,
                                width: 20,
                              ),
                              SizedBox(width: 5),
                              Text('0', style: kTitle4Style),
                              SizedBox(width: 3),
                              Text('kcal', style: kTitle3Style),
                            ],
                          ),
                        ],
                      ),
                      CircularPercentIndicator(
                        radius: 100.0,
                        lineWidth: 10.0,
                        animation: true,
                        backgroundWidth: 3,
                        percent: percentage / 100,
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            new Text(
                              percentage.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0,
                                  color: Colors.white),
                            ),
                            new Text(
                              'kcal ',
                              style: new TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12.0,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: kGreenColor,
                      ),
                    ],
                  )),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                      color: kIndigoColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('0',
                              style: kTitle3Style.copyWith(
                                  color: Colors.white, fontSize: 22)),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              SizedBox(width: 5),
                              Text('Steps walked',
                                  style: kTitle4Style.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                      Icon(
                        Icons.directions_walk,
                        size: 36.0,
                        color: Colors.white,
                      ),
                    ],
                  )),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                      color: kIndigoColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isDataSet
                              ? Text(bmi.toStringAsFixed(3),
                                  style: kTitle3Style.copyWith(
                                      color: Colors.white, fontSize: 22))
                              : Text('2109',
                                  style: kTitle3Style.copyWith(
                                      color: Colors.white, fontSize: 22)),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text('Body Mass Index',
                                  style: kTitle4Style.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                      Icon(
                        Icons.donut_large,
                        size: 36.0,
                        color: Colors.white,
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
