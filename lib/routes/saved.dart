import 'package:flutter/material.dart';

class Saved extends StatelessWidget {
  const Saved({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Saved Surveys',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Image.network('https://ik.imagekit.io/7i3fql4kv7/survey_headers/alice-donovan-rouse-yu68fUQDvOI-unsplash.jpg',
      height: 100,
      width: 100,),
    );
  }
}
