import 'package:amazonclone/constants/error_handling.dart';
import 'package:amazonclone/constants/utils.dart';
import 'package:amazonclone/models/users.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
}