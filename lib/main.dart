import 'package:flutter/material.dart';
import './screens/login.dart';
import 'package:provider/provider.dart';
import './screens/splash_screen.dart';
import './screens/home.dart';
import 'package:foodly/providers/auth.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Auth(),
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Food.ly',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(),
       home: auth.isAuth
              ? Home()
              : FutureBuilder(
                  future: auth.tryautoLogin(),
                  builder: (ctx, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : Login(),
                ),
        ),
      ),
    );
  }
}
