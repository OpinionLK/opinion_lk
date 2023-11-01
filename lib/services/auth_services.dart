import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:opinion_lk/models/login_response.dart';
// import 'package:opinion_lk/routes/main_app.dart';
import 'package:opinion_lk/models/user.dart';
import 'package:opinion_lk/styles.dart';
import 'package:opinion_lk/widgets/toast.dart';
// import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<bool> loginUser(BuildContext context, String email, String password) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3002/api/auth/login'),
      // Uri.parse('http://localhost:3002/api/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response,
      // then parse the JSON.
      LoginResponse loginResponse =
          LoginResponse.fromJson(jsonDecode(response.body));

      // Save token to shared pref
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', loginResponse.token);
      print(prefs.getString('token'));

      return true;
    } else if (response.statusCode == 401) {
      // Fluttertoast.showToast(
      //   msg: "Please check your email and password",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      // );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: CustomToast(
            backgroundColor: AppColors.error,
            foregroundColor: Colors.white,
            message: 'Please check your email and password!',
            iconData: Icons.error,
          ),
        ),
      );
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load response');
    }

    return false;
  }

  Future<User?> fetchUserData(String token) async {
    final response = await http.get(
      Uri.parse(
          'http://10.0.2.2:3002/api/user/userdata'), // replace with your actual API URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      User user = userFromJson(response.body);
      print(user);
      return user;

      // Add to user provider
    } else {
      return null;
    }
  }
}

