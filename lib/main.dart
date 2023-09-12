import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
        child: SvgPicture.asset('assets/logo.svg'), // replace with your logo asset
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 50),
            Align(
              alignment: Alignment.topCenter,
              child: SvgPicture.asset('assets/logo.svg', height: 50), // replace with your logo asset
            ),
            SizedBox(height: 150),
            Text(
              'Welcome',
              style: TextStyle(fontSize: 30.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Text(
              'A no nonsense survey platform that rewards you',
              style: TextStyle(fontSize: 14.0),
              textAlign: TextAlign.center,
            ),
            // Spacer(),
            const SizedBox(height: 230),
            Container(
              height: 54.0,  // set height
              width: 206.0,  // set width
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6C63FF),
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // set border radius
                  ),
                ),
                onPressed: () {},
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
                  textStyle: TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // set border radius
                  ),
                ),
                onPressed: () {},
                child: Text('Create account'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
