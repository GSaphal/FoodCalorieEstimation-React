import 'package:flutter/material.dart';
import 'package:foodly/screens/steps.dart';
import '../constants/theme_constants.dart';
import '../widgets/bottom_navigation.dart';
import './dashboard.dart';
import '../widgets/flutter_icons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart' as path;
import '../screens/imagedisplay.dart';
import '../screens/steps.dart';
import '../utils/api.dart';
import '../screens/profile.dart';
import '../screens/bmi.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    Steps(),
    BMI(),
    Profile(),
  ];
  bool _isLoading = false;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  PermissionStatus _status;

  @override
  void initState() {
    super.initState();

    PermissionHandler()
        .checkPermissionStatus(PermissionGroup.camera)
        .then(_updateStatus);
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? loadingScreen
        : Scaffold(
            backgroundColor: Color.fromRGBO(245, 247, 251, 1),
            body: Container(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: FABBottomAppBar(
              color: Colors.white,
              backgroundColor: kIndigoColor,
              selectedColor: kGreenColor,
              onTabSelected: _onItemTapped,
              notchedShape: CircularNotchedRectangle(),
              items: [
                FABBottomAppBarItem(
                    iconData: FlutterIcons.dumbell, text: 'Home'),
                FABBottomAppBarItem(
                    iconData: FlutterIcons.running, text: 'Money'),
                FABBottomAppBarItem(iconData: FlutterIcons.stats, text: 'Fund'),
                FABBottomAppBarItem(
                    iconData: FlutterIcons.settings, text: 'Profile'),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _displayOptionsDialog();
              },
              child: Icon(
                Icons.camera_alt,
                size: 32,
                color: Colors.white,
              ),
              backgroundColor: kIndigoColor,
              elevation: 2.0,
            ),
          );
  }

  void _displayOptionsDialog() async {
    await _optionsDialogBox();
  }

  Future<void> _optionsDialogBox() {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: new Text('Take Photo'),
                    onTap: _askPermission,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  GestureDetector(
                    child: new Text('Select Image From Gallery'),
                    onTap: imageSelectorGallery,
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _askPermission() {
    PermissionHandler()
        .requestPermissions([PermissionGroup.camera]).then(_onStatusRequested);
  }

  void _onStatusRequested(Map<PermissionGroup, PermissionStatus> value) {
    final status = value[PermissionGroup.camera];
    if (status == PermissionStatus.granted) {
      imageSelectorCamera();
    } else {
      _updateStatus(status);
    }
  }

  _updateStatus(PermissionStatus value) {
    if (value != _status) {
      setState(() {
        _status = value;
      });
    }
  }

  void imageSelectorCamera() async {
    Navigator.pop(context);
    var imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );
    upload(imageFile);
  }

  void imageSelectorGallery() async {
    Navigator.pop(context);
    var imageFile1 = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    upload(imageFile1);
  }

  void upload(File imageFile) async {
    setState(() {
      _isLoading = true;
    });
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));

    var length = await imageFile.length();
    print("${Api.api}detect");
    var uri = Uri.parse("${Api.api}detect");

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: path.basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      setState(() {
        _isLoading = false;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageDisplay(text: value),
          ));

      print(jsonDecode(value)['masked_image']);
    });
  }

  Widget get loadingScreen {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 15),
              Text('Calculating Calories', style: kLoadingStyle),
            ],
          )),
    );
  }
}
