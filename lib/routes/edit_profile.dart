import 'package:http/http.dart' as http; // create class survey_form_page
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:opinion_lk/models/survey.dart';
import 'package:opinion_lk/services/survey_services.dart';
import 'package:opinion_lk/styles.dart';
// import 'package:opinion_lk/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: 
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Details and input boxes to change them
              const SizedBox(height: 20), 
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 20),
                  const Text('Name: '),
                  const SizedBox(width: 20),
                  Container(
                    width: 150.0,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Name',
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: 150.0,
                child: FilledButton(
                  style: ElevatedButton.styleFrom(
                          primary: AppColors.primaryColor, // This is your background color
                        ),
                  onPressed: () { null; },
                  child: const Text("Save")
                ),
              ),
            ],
          ),
        )
    );
  }
}
