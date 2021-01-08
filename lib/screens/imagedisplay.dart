import 'package:flutter/material.dart';
import 'package:foodly/constants/theme_constants.dart';
import 'dart:convert';
import './home.dart';
import '../utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ImageDisplay extends StatefulWidget {
  final String text;
  ImageDisplay({Key key, @required this.text}) : super(key: key);
  @override
  _ImageDisplayState createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {
  var data;
  var totalCalorie;
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
      totalCalorie = jsonDecode(widget.text)["totalCalorie"];
      isDataSet = true;
    });
    print(totalCalorie);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Image.network('${Api.image}maskedImage/' +
                    jsonDecode(widget.text)['masked_image']),
              ),
              SizedBox(height: 10),
              Container(
                  child: ListView.builder(
                      itemCount: jsonDecode(widget.text)['calorie'].length,
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.only(top: 0),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int position) {
                        return ListTile(
                            title: new Text(
                                '${jsonDecode(widget.text)['calorie'][position]['name']} with ${jsonDecode(widget.text)['calorie'][position]['calorie']} calorie',
                                style: kTitle3Style));
                      })),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ));
                  },
                  child: Text('Save', style: kButtonStyle),
                  color: kIndigoColor,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ));
                  },
                  child: Text('Cancel', style: kButtonStyle),
                  color: Colors.grey,
                ),
              )

              // ListView.builder(
              //     itemCount: jsonDecode(text)['calorie'].length,
              //     itemBuilder: (BuildContext context, int index) {
              //       return Container();
              //     })
            ],
          ),
        ),
      ),
    );
  }
}
