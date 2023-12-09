import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:amazon_clone/providers/user_provider.dart';

class AuthService {
  void signUpUser(
      {required String email,
      required String password,
      required String name,
      required BuildContext context}) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        type: '',
        token: '',
      );
      http.Response res = await http.post(
        Uri.parse('${GlobalVariables.uri}/api/signup'),
        body: jsonEncode(user.toMap()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        resp: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Accoun created! Login with the same credentials',
          );
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  void signInUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    http.Response res = await http.post(
      Uri.parse('${GlobalVariables.uri}/api/signup'),
      body: jsonEncode(
        {
          'email': email,
          'password': password,
        },
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    // ignore: use_build_context_synchronously
    httpErrorHandle(
      resp: res,
      context: context,
      onSuccess: () async {
        showSnackBar(
          context,
          'Accoun created! Login with the same credentials',
        );
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
        // ignore: use_build_context_synchronously
        Provider.of<UserProvider>(context, listen: false).setUser(res.body);
      },
    );
  }
}