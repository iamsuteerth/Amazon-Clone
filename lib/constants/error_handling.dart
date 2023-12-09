import 'dart:convert';

import 'package:amazon_clone/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response resp,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (resp.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(
        context,
        jsonDecode(resp.body)['msg'],
      );
      break;
    case 500:
      showSnackBar(
        context,
        jsonDecode(resp.body)['error'],
      );
      break;
    default:
      showSnackBar(
        context,
        jsonDecode(resp.body),
      );
  }
}
