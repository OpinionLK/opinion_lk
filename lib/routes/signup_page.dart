import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

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
                controller: _usernameController,
                style: TextStyle(height: 1.0),
                decoration: InputDecoration(
                  labelText: 'Username',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF00BFA6), width: 1.5), // app-purple
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
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

            SizedBox(
              height: 25,
            ),
            // Password TextField
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
                      controller: _passwordController,
                      style: TextStyle(height: 1.0),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF00BFA6), width: 1.5), // app-green
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      obscureText: true,
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
                      controller: _passwordController,
                      style: TextStyle(height: 1.0),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF00BFA6), width: 1.5), // app-green
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      obscureText: true,
                    ),
                  ),
                ),
              ],
            ),


            SizedBox(height: 20.0),

            Container(
              height: 54.0, // set height
              width: 350, // set width
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00BFA6),
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontFamily: 'DM Sans', fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // set border radius
                  ),
                ),
                onPressed: () {
                  print('Username: ${_usernameController.text}');
                  print('Password: ${_passwordController.text}');
                  print('Email is:${_emailController.text}');
                },
                child: Text('Create account'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
