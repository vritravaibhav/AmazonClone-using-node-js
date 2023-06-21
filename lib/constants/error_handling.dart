import 'dart:convert';

import 'package:amazonclone/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSucccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSucccess();
      // showSnackbar(context, "Successfully Registered");
      break;
    case 400:
      showSnackbar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      showSnackbar(context, jsonDecode(response.body)['error']);
      break;
    default:
      showSnackbar(context, jsonDecode(response.body));
  }
}
