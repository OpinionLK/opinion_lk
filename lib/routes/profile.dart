import 'package:flutter/material.dart';
import 'package:opinion_lk/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatelessWidget {
  final User? user;
  const Profile({super.key, required this.user});

  Future<void> _resetPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

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
            Text('helo'),
            Text(user!.email),
            Text(user!.firstname),
            Text(user!.lastname),

            FilledButton(
              onPressed: () async {
                await _resetPreferences();
              },
              child: const Text("Logout"),
            )
          ],
        ),
      ),
    );
  }
}
