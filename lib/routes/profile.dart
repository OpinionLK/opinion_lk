import 'package:flutter/material.dart';
import 'package:opinion_lk/models/user.dart';
import 'package:opinion_lk/routes/edit_profile.dart';
import 'package:opinion_lk/styles.dart';
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
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfile()), // replace with your actual ProfileEditPage
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                // Text('helo'), // This exists for debugging hehe
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: AppColors.primaryColor,
                      width: 2.5,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      user?.profilePicture 
                        ?? 'https://ik.imagekit.io/7i3fql4kv7/survey_headers/alice-donovan-rouse-yu68fUQDvOI-unsplash.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(user?.firstname ??"FirstName", style: AppTextStyles.header),
                    SizedBox(width: 4),  
                    Text(user?.lastname ??"Lastname", style: AppTextStyles.header),
                    ],
                ),
                Text(user?.email ??"Email", style: AppTextStyles.subtitle),
                const Divider(
                  height: 20,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Coupons Redeemed', style: AppTextStyles.title),
                
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(10, (index) {
                            return Card(
                              color: AppColors.secondaryColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: const SizedBox(
                                  width: 200,
                                  height: 75,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Coupon Name', style: AppTextStyles.title),
                                      Text('Description Goes here', style: AppTextStyles.normal),
                                    ]),
                                  ),
                                ),
                              );
                            }
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 20,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                  color: Colors.black,
                ),
                // const Padding(
                //   padding: EdgeInsets.all(10.0),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text('Interested Topics', style: AppTextStyles.title),
                //     ],
                //   ),
                // ),
                // //filter chips
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: List.generate(10, (index) {
                //       return Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Chip(
                //           label: Text('Topic $index'),
                //           backgroundColor: AppColors.secondaryColor,
                //           elevation: 0,
                //           shape: RoundedRectangleBorder(
                //             side: BorderSide(
                //               color: Theme.of(context).colorScheme.outline,
                //             ),
                //             borderRadius: const BorderRadius.all(Radius.circular(12)),
                //           ),
                //         ),
                //       );
                //     }),
                //   ),
                // ),
      
                
                // const Divider(
                //   height: 20,
                //   thickness: 1,
                //   indent: 20,
                //   endIndent: 20,
                //   color: Colors.black,
                // ),
                Container(
                  width: 150.0,
                  child: FilledButton.tonal(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey[200], // background color
                      onPrimary: Colors.black, // text color
                    ),
                    onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditProfile()), // replace with your actual ProfileEditPage
                    );
                  },
                  child: const Text("Edit Profile")),
                ),
      
                Container(
                  width: 150.0,
                  child: FilledButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.primaryColor, // This is your background color
                    ),
                    onPressed: () async {
                      await _resetPreferences();
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                    child: const Text("Logout"),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
