import 'package:flutter/material.dart';
import 'package:opinion_lk/models/user.dart';

class Profile extends StatelessWidget {
  final User? user;
  const Profile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    //text widget with the user's email, name, lastname and password
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(user!.email),
            Text(user!.firstname),
            Text(user!.lastname),
            Text(user!.id),
          ],
        ),
      ),
    );
  }
}
