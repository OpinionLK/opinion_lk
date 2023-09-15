import 'dart:convert'; //for jsonEncode
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:opinion_lk/routes/navbar.dart';

// import 'package:opinion_lk/main.dart';
// import 'package:opinion_lk/routes/surveys.dart';

Future<void> loginUser(BuildContext context, String email, String password) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:3002/api/auth/login'),
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
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    if (jsonResponse['type'] == 'user') {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NavigationBarApp()),
      );
    }
  } else if (response.statusCode == 401) {
    Fluttertoast.showToast(
      msg: "Please check your email and password",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load response');
  }
}


class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String get email => emailController.text;
  String get password => passwordController.text;
  bool _isLoading = false; 
  bool _isHidden = true; // Add this line

  void _toggleVisibility(){
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 100),
            Align(
              alignment: Alignment.topCenter,
              child: SvgPicture.asset('assets/logo.svg',
                  height: 40), // replace with your logo asset
            ),
            SizedBox(height: 60),

            Text(
              'Log in',
              style: TextStyle(
                fontFamily: 'DM Sans',
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 50),

            // Email TextField
            Theme(
              data: Theme.of(context).copyWith(
                primaryColor: Color(0xFF6259F5), // app-purple
                inputDecorationTheme: InputDecorationTheme(
                  labelStyle: TextStyle(color: Color(0xFF1B2559)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF6259F5), width: 1.5), // app-purple
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: Color(0xFF6259F5), // app-purple
                  selectionColor: Color(0xFF6259F5), // app-purple
                  selectionHandleColor: Color(0xFF6259F5), // app-purple
                ),
              ),
              child: TextField(
                cursorColor: Color(0xFF6259F5), // app-purple
                controller: emailController,
                style: TextStyle(height: 1.0),
                decoration: InputDecoration(
                  labelText: 'Email',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF6259F5), width: 1.5), // app-purple
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 25,
            ),
            // Password TextField
            Theme(
              data: Theme.of(context).copyWith(
                primaryColor: Color(0xFF6259F5), // app-purple
                inputDecorationTheme: InputDecorationTheme(
                  labelStyle: TextStyle(color: Color(0xFF1B2559)), // app-purple
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF6259F5), width: 1.5), // app-purple
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: Color(0xFF6259F5), // app-purple
                  selectionColor: Color(0xFF6259F5), // app-purple
                  selectionHandleColor: Color(0xFF6259F5), // app-purple
                ),
              ),
              child: TextField(
                cursorColor: Color(0xFF6259F5), // app-purple
                controller: passwordController,
                style: TextStyle(height: 1.0),
                decoration: InputDecoration(
                  labelText: 'Password',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF6259F5), width: 1.5), // app-purple
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                obscureText: true,
              ),
            ),

            SizedBox(height: 20.0),

             Container(
              height: 54.0, // set height
              width: 350, // set width
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isLoading ? Color.fromARGB(255, 161, 154, 255) : Color(0xFF6C63FF), // Change the button color when _isLoading is true
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontFamily: 'DM Sans', fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // set border radius
                  ),
                ),
                onPressed: _isLoading ? null : () async { // Disable the button if _isLoading is true
                  setState(() {
                    _isLoading = true; // Set _isLoading to true when the request is sent
                  });

                  await loginUser(context, email, password);

                  setState(() {
                    _isLoading = false; // Set _isLoading back to false when the response is received
                  });
                },
                child: _isLoading ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF))) : Text('Log in'), // Show a progress indicator if _isLoading is true
              ),
            ),
          ],
        ),
      ),
    );
  }
}