import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

import 'package:opinion_lk/routes/login_page.dart';
import 'package:opinion_lk/routes/signup_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primaryColor: Color(0xFF6C63FF),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).copyWith(
          secondary: Color(0xFF00BFA6),  // your accent color
        ),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
            () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset('assets/logo.svg', height: 40,), // replace with your logo asset
      ),
    );
  }
}

class HomePage extends StatelessWidget {
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
              child: SvgPicture.asset('assets/logo.svg', height: 40), 
            ),
            SizedBox(height: 100),
            Text(
              'Welcome',
              style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Text(
              'It pays to have opinions',
              style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    ),
              textAlign: TextAlign.center,
            ),
            // Spacer(),
            const SizedBox(height: 200),
            Container(
              height: 54.0,  // set height
              width: 206.0,  // set width
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6C63FF),
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: 16
                    ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // set border radius
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text('Log in'),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              height: 54.0,  // set height
              width: 206.0,  // set width
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00BFA6),
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: 16
                    ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // set border radius
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupPage()),
                  );
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
