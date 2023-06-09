import 'dart:convert';
//import 'dart:js_interop';

import 'package:amazonclone/constants/error_handling.dart';
import 'package:amazonclone/constants/utils.dart';
import 'package:amazonclone/home/screens/home_screens.dart';
import 'package:amazonclone/models/users.dart';
import 'package:amazonclone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/global_variable.dart';

class AuthService {
  Future<void> signUpUser({
    required BuildContext context,
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      User user = User(
          id: "",
          name: name,
          email: email,
          password: password,
          address: "",
          type: "",
          token: "");
      http.Response res = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8',
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSucccess: () {
            showSnackbar(context, "Successfully Registered");
          });
      print(res.statusCode);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  //Signin User
  Future<void> signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSucccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            // print(prefs.getString('x-auth-token'));

            Navigator.pushNamedAndRemoveUntil(
              context,
              HomeScreen.routeName,
              (route) => false,
            );
          });

      print(res.statusCode);
      print("vaibhavlol");
    } catch (e) {
      showSnackbar(context, e.toString());
      print("good");
    }
  }

  //Signin User
  Future<void> getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      //print("vaibhavhshshsh");
      print(token);
      // print('$uri/tokenIsValid');
      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
      );

      var response = jsonDecode(tokenRes.body);
      // print(tokenRes.body.toString());
      if (response == true) {
        print('$uri/');
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
        );
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }

      // http.Response res = await http.post(
      //   Uri.parse('$uri/api/signin'),
      //   body: jsonEncode({
      //     'email': email,
      //     'password': password,
      //   }),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      // );

      // httpErrorHandle(
      //     response: res,
      //     context: context,
      //     onSucccess: () async {
      //       SharedPreferences prefs = await SharedPreferences.getInstance();
      //       Provider.of<UserProvider>(context, listen: false).setUser(res.body);
      //       await prefs.setString(
      //           'x-auth-token', jsonDecode(res.body)['token']);

      //       Navigator.pushNamedAndRemoveUntil(
      //         context,
      //         HomeScreen.routeName,
      //         (route) => false,
      //       );
      //     });

      // print(res.statusCode);
      print("vaibhavhaha");
    } catch (e) {
      showSnackbar(context, e.toString());
      print("good");
    }
  }
}
