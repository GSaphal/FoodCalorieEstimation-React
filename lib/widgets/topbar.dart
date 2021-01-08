import 'package:flutter/material.dart';
import '../constants/theme_constants.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kIndigoColor,
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            size: 24.0,
            color: Colors.white,
          ),
          Icon(
            Icons.notifications,
            size: 24.0,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
