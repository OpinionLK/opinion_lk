// import 'package:http/http.dart' as http; // create class survey_form_page
// import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:opinion_lk/models/survey.dart';
import 'package:opinion_lk/models/user.dart';
import 'package:opinion_lk/providers/user_provider.dart';
// import 'package:opinion_lk/services/survey_services.dart';
import 'package:opinion_lk/styles.dart';
import 'package:provider/provider.dart';
import 'package:gap/gap.dart';
// import 'package:opinion_lk/styles.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  CustomTextField({required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.0,
      height:55,
      alignment: Alignment.center,
      child: TextField(
        cursorColor: AppColors.primaryColor,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}


class EditProfile extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfile> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = Provider.of<UserProvider>(context, listen: false).user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Gap(20),
                  Container(
                    width:90,
                    child: const Text('First Name:',)
                  ),
                  const Gap(10),
                  CustomTextField(
                    controller: TextEditingController(text: user?.firstname),
                    hintText: 'First Name',
                  ),
                ],
              ),
              Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Gap(20),
                  Container(
                    width:90,
                    child: const Text('Last Name:',)
                  ),
                  const Gap(10),
                  CustomTextField(
                    controller: TextEditingController(text: user?.lastname),
                    hintText: 'Last Name:',
                  ),
                ],
              ),
              Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Gap(20),
                  Container(
                    width:90,
                    child: const Text('Email:',)
                  ),
                  const Gap(10),
                  CustomTextField(
                    controller: TextEditingController(text: user?.email),
                    hintText: 'Email',
                  ),
                ],
              ),
              Gap(50),
              
              //Button//
              Container(
                width: 150.0,
                child: FilledButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColors
                          .primaryColor, // This is your background color
                    ),
                    onPressed: () {
                      null;
                    },
                    child: const Text("Save")),
              ),
            ],
          ),
        ));
  }
}
