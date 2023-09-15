import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert'; //for jsonEncode
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:opinion_lk/routes/navbar.dart';

Future<void> signupUser(BuildContext context, String firstName, String lastName, String email, String password) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:3002/api/auth/signup'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response,
    // then parse the JSON.
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NavigationBarApp()),
    );
  } else if (response.statusCode == 401) {
    Fluttertoast.showToast(
      msg: "Please check your details",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load response');
  }
}


class SignupPage extends StatefulWidget {
  _SignupPageState createState() => _SignupPageState();
}


class _SignupPageState extends State<SignupPage> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String get email => _emailController.text;
  String get password => _passwordController.text;
  String get firstName => _firstnameController.text;
  String get lastName => _lastnameController.text;

  bool _isLoading = false; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 100),
            Align(
              alignment: Alignment.topCenter,
              child: SvgPicture.asset('assets/logo.svg', height: 40), // replace with your logo asset
              ),
            SizedBox(height: 40),

            Text(
              'Sign Up',
              style: TextStyle(
                fontFamily: 'DM Sans',
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 50),

            // Username TextField
            Row(
              children: <Widget>[
                Expanded(
                  flex: 45,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      primaryColor: Color(0xFF00BFA6), // app-green
                      inputDecorationTheme: InputDecorationTheme(
                        labelStyle: TextStyle(color: Color(0xFF1B2559)), // black
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF00BFA6), width: 1.5), // app-green
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      textSelectionTheme: TextSelectionThemeData(
                        cursorColor: Color(0xFF00BFA6), // app-green
                        selectionColor: Color(0xFF00BFA6), // app-green
                        selectionHandleColor: Color(0xFF00BFA6), // app-green
                      ),
                    ),
                    child: TextField(
                      cursorColor: Color(0xFF00BFA6), // app-green
                      controller: _firstnameController,
                      style: TextStyle(height: 1.0),
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF00BFA6), width: 1.5), // app-green
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20), // You can adjust the space between the fields as needed.
                Expanded(
                  flex: 45,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      primaryColor: Color(0xFF00BFA6), // app-green
                      inputDecorationTheme: InputDecorationTheme(
                        labelStyle: TextStyle(color: Color(0xFF1B2559)), // black
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF00BFA6), width: 1.5), // app-green
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      textSelectionTheme: TextSelectionThemeData(
                        cursorColor: Color(0xFF00BFA6), // app-green
                        selectionColor: Color(0xFF00BFA6), // app-green
                        selectionHandleColor: Color(0xFF00BFA6), // app-green
                      ),
                    ),
                    child: TextField(
                      cursorColor: Color(0xFF00BFA6), // app-green
                      controller: _lastnameController,
                      style: TextStyle(height: 1.0),
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF00BFA6), width: 1.5), // app-green
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
            // Email TextField
            Theme(
              data: Theme.of(context).copyWith(
                primaryColor: Color(0xFF00BFA6), // app-purple
                inputDecorationTheme: InputDecorationTheme(
                  labelStyle: TextStyle(color: Color(0xFF1B2559)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF00BFA6), width: 1.5), // app-purple
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: Color(0xFF00BFA6), // app-purple
                  selectionColor: Color(0xFF00BFA6), // app-purple
                  selectionHandleColor: Color(0xFF00BFA6), // app-purple
                ),
              ),
              child: TextField(
                cursorColor: Color(0xFF00BFA6), // app-purple
                controller: _emailController,
                style: TextStyle(height: 1.0),
                decoration: InputDecoration(
                  labelText: 'Email',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF00BFA6), width: 1.5), // app-purple
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),

            SizedBox(height: 25,),
            // Password TextField
            Theme(
              data: Theme.of(context).copyWith(
                primaryColor: Color(0xFF00BFA6), // app-purple
                inputDecorationTheme: InputDecorationTheme(
                  labelStyle: TextStyle(color: Color(0xFF1B2559)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF00BFA6), width: 1.5), // app-purple
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: Color(0xFF00BFA6), // app-purple
                  selectionColor: Color(0xFF00BFA6), // app-purple
                  selectionHandleColor: Color(0xFF00BFA6), // app-purple
                ),
              ),
              child: TextField(
                cursorColor: Color(0xFF00BFA6), // app-purple
                controller: _passwordController,
                style: TextStyle(height: 1.0),
                decoration: InputDecoration(
                  labelText: 'Password',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF00BFA6), width: 1.5), // app-purple
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                obscureText: true,
              ),
            ),


            SizedBox(height: 20.0),

            Container(
              height: 54.0, // set height
              width: 350, // set wid
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isLoading ? Color.fromARGB(255, 164, 237, 227) : Color(0xFF00BFA6), // Change the button color when _isLoading is true
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

                  await signupUser(context, firstName, lastName, email, password);

                  setState(() {
                    _isLoading = false; // Set _isLoading back to false when the response is received
                  });
                },
                child: _isLoading ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00BFA6))) : Text('Create account'), // Show a progress indicator if _isLoading is true
              ),
            ),
          ],
        ),
      ),
    );
  }
}
