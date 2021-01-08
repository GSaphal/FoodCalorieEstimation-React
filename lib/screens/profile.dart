import 'package:flutter/material.dart';
import 'package:foodly/constants/theme_constants.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var data;
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

      isDataSet = true;
    });
  }

  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          color: kIndigoColor,
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Profile',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ],
          ),
        ),
        Container(
          height: 200,
          decoration: BoxDecoration(
              color: kIndigoColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/lunch.png'),
                    minRadius: 40,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              isDataSet
                  ? Text(
                      data['name'],
                      style: TextStyle(fontSize: 22.0, color: Colors.white),
                    )
                  : Text(
                      "",
                      style: TextStyle(fontSize: 22.0, color: Colors.white),
                    ),
              isDataSet
                  ? Text(
                      data['email'],
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                    )
                  : Text(
                      "",
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                    )
            ],
          ),
        ),
        Container(
          // height: 50,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: ListTile(
                    title: isDataSet
                        ? Text(
                            data['height'] + "in",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: kIndigoColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0),
                          )
                        : Text(
                            "",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: kIndigoColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0),
                          ),
                    subtitle: Text(
                      "Height",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: kIndigoColor),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: ListTile(
                    title: isDataSet
                        ? Text(
                            data['age'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: kIndigoColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0),
                          )
                        : Text(
                            "18",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: kIndigoColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0),
                          ),
                    subtitle: Text(
                      "Age",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: kIndigoColor),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: ListTile(
                    title: isDataSet
                        ? Text(
                            data['weight'] + "kg",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: kIndigoColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0),
                          )
                        : Text(
                            "",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: kIndigoColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0),
                          ),
                    subtitle: Text(
                      "Weight",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: kIndigoColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Container(
            color: kIndigoColor,
            alignment: Alignment.center,
            width: 140,
            child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("/");
                  Provider.of<Auth>(context, listen: false).logout();
                },
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
                color: kIndigoColor),
          ),
        ),
      ],
    );
  }
}
