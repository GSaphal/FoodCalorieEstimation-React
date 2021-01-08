import 'package:flutter/material.dart';
import 'package:foodly/constants/theme_constants.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class BMI extends StatefulWidget {
  @override
  _BMIState createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  var data;
  var bmi;
  var bmi_category;
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
      bmi_category = bmi <= 18.5
          ? "UnderWeight"
          : bmi > 18.5 && bmi < 24.9
              ? "Normal Weight"
              : bmi > 25 && bmi < 29.9
                  ? "Overweight"
                  : bmi > 30 ? "Obesity" : "No match";
      isDataSet = true;
    });
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          child: Column(
        children: [
          Container(
            color: kIndigoColor,
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('BMI Tracker',
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
                        : Text('',
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
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
                            ? Text(data['height'] + " in",
                                style: kTitle3Style.copyWith(
                                    color: Colors.white, fontSize: 22))
                            : Text('',
                                style: kTitle3Style.copyWith(
                                    color: Colors.white, fontSize: 22)),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(' Height',
                                style: kTitle4Style.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.scatter_plot,
                      size: 36.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
                            ? Text(data['weight'] + " kg",
                                style: kTitle3Style.copyWith(
                                    color: Colors.white, fontSize: 22))
                            : Text('80 kg',
                                style: kTitle3Style.copyWith(
                                    color: Colors.white, fontSize: 22)),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(' Weight',
                                style: kTitle4Style.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.fitness_center,
                      size: 36.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
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
                        ? Text(bmi_category,
                            style: kTitle3Style.copyWith(
                                color: Colors.white, fontSize: 22))
                        : Text('',
                            style: kTitle3Style.copyWith(
                                color: Colors.white, fontSize: 22)),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text('Your BMI Category',
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
            ),
          ),
        ],
      )),
    );
  }
}
