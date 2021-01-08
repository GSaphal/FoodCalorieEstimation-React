import 'package:flutter/material.dart';
import 'package:foodly/constants/theme_constants.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../widgets/topbar.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';

class Steps extends StatefulWidget {
  @override
  _StepsState createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  Stream<StepCount> _stepCountStream;
  // Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  // void onPedestrianStatusChanged(PedestrianStatus event) {
  //   print(event);
  //   setState(() {
  //     _status = event.status;
  //   });
  // }

  // void onPedestrianStatusError(error) {
  //   print('onPedestrianStatusError: $error');
  //   setState(() {
  //     _status = 'Pedestrian Status not available';
  //   });
  //   print(_status);
  // }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    // _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    // _pedestrianStatusStream
    //     .listen(onPedestrianStatusChanged)
    //     .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
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
                Text('Steps Tracker',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                Icon(
                  Icons.search,
                  size: 24.0,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                  color: kIndigoColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularPercentIndicator(
                    radius: 200.0,
                    lineWidth: 10.0,
                    animation: true,
                    backgroundWidth: 3,
                    percent: 0,
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        new Text(
                          _steps,
                          style: new TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 40.0,
                              color: Colors.white),
                        ),
                        new Text(
                          'steps ',
                          style: new TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 16.0,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: kGreenColor,
                  ),
                ],
              )),
        ],
      )),
    );
  }
}
