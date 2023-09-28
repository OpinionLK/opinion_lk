import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:opinion_lk/models/survey.dart';
import 'package:opinion_lk/models/user.dart';
import 'package:opinion_lk/routes/surveys.dart';
import 'package:opinion_lk/services/auth_services.dart';
import 'package:opinion_lk/styles.dart';
import 'package:opinion_lk/widgets/toast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/user_provider.dart';
import 'profile.dart';
import 'coupons.dart';
import 'saved.dart';

// /// Flutter code sample for [NavigationBar].

// void main() => runApp(const NavigationBarApp());

// class NavigationBarApp extends StatelessWidget {
//   const NavigationBarApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(home: NavigationExample());
//   }
// }

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysHide;

  void getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      // get user data from api here
      User? userData = await AuthService().fetchUserData(token);

      if (userData != null) {
        // set user to provider here
        Provider.of<UserProvider>(context, listen: false).setUser(userData);
      } else {
        // if user data is null, cl ear token from shared pref
        prefs.remove('token');
        
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: CustomToast(
            backgroundColor: AppColors.error,
            foregroundColor: Colors.white,
            message: 'please login again',
            iconData: Icons.error,
          ),
        ),
      );

        // navigate to login page here
        Navigator.pushReplacementNamed(context, '/login');
      }
    }


  }
  
    @override
    Widget build(BuildContext context) {
      getUser();

      return Theme(data: ThemeData(
      // Define your custom styles here
          primaryColor: AppColors.primaryColor, 
          canvasColor: Colors.white,
          navigationBarTheme: const NavigationBarThemeData(
            backgroundColor: AppColors.secondaryColor, // Replace with your desired color
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(
              color: AppColors.dark,
              fontSize: 24,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      
        child: Scaffold(
          bottomNavigationBar: NavigationBar(
            labelBehavior: labelBehavior,
            selectedIndex: currentPageIndex,
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            destinations: const <Widget>[
              NavigationDestination(
                selectedIcon: Icon(Icons.dashboard),
                icon: Icon(Icons.dashboard_outlined),
                label: 'Surveys',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.bookmark),
                icon: Icon(Icons.bookmark_border),
                label: 'Saved',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.confirmation_number),
                icon: Icon(Icons.confirmation_num_outlined),
                label: 'Coupons',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.account_circle),
                icon: Icon(Icons.account_circle_outlined),
                label: 'Profile',
              ),
            ],
          ),
          body: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: SurveysPage(),
              // child: Saved(),
            ),
            Container(
              alignment: Alignment.center,
              child: const Saved(),
            ),
            Container(
              color: Colors.blue,
              alignment: Alignment.center,
              child: Coupons(),
            ),
            Container(
              color: Colors.grey,
              alignment: Alignment.center,
              child: Profile(
                  user: Provider.of<UserProvider>(context, listen: false).user),
            ),
          ][currentPageIndex],
        ),
      );
    }
}
