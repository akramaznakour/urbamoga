/// flutter libraries
import 'package:flutter/material.dart';

/// UI libraries
import 'package:equinox/equinox.dart';

/// Screens
import 'package:urbamoga/screens/home/home.dart';
import 'package:urbamoga/screens/splashscreen/splashscreen.dart';


/// Main function
void main() => runApp(Urbamoga());

/// Main App Widget
class Urbamoga extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EquinoxApp(
        debugShowCheckedModeBanner: false,
        title: 'Urbamoga',
        theme: EqThemes.defaultLightTheme,
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          "/": (BuildContext context) => SplashScreen(),
          "/home": (BuildContext context) => Home(),
        });
  }
}