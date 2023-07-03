import 'package:amazonclone/features/auth/screens/auth_screen.dart';
import 'package:amazonclone/home/screens/home_screens.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routesettings) {
  switch (routesettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routesettings, builder: (_) => const AuthScreen());

    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routesettings, builder: (_) => const HomeScreen());
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(child: Text("Screen doesnot exist")),
              ));
  }
}
