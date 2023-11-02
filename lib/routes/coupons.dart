import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:opinion_lk/models/user.dart';
import 'package:opinion_lk/providers/user_provider.dart';
import 'package:opinion_lk/routes/surveys.dart';
import 'package:opinion_lk/services/coupon_services.dart'; // Import the service
import 'package:opinion_lk/models/coupon.dart';
import 'package:opinion_lk/styles.dart';
import 'package:http/http.dart' as http;
import 'package:opinion_lk/widgets/toast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:opinion_lk/services/auth_services.dart';

class CouponsPage extends StatefulWidget {
  late final User? user;
  @override
  _CouponsState createState() => _CouponsState();
}

class _CouponsState extends State<CouponsPage> {
  late Future<List<Coupon>> futureCoupons;

  @override
  void initState() {
    super.initState();
    futureCoupons = CouponService().fetchCoupons();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coupons'),
      ),
      body: Center(
        child: FutureBuilder<List<Coupon>>(
          future: futureCoupons,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Coupon> data = snapshot.data!;
              return _couponsListView(data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  ListView _couponsListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return CouponCard(coupon: data[index]);
        });
  }
}

class CouponCard extends StatelessWidget {
  final Coupon coupon;

  const CouponCard({required this.coupon});

  @override
  Widget build(BuildContext context) {

    String couponDescription = coupon.description;
    List<String> splitDescription = splitIntoLines(couponDescription, 44);
    return InkWell(
      onTap: () {
        // Add your navigation logic here
      },
      child: Center(
        child: Container(
          height: 90,
          child: Card(
            elevation: 0,
            shape: const RoundedRectangleBorder(
              side: BorderSide(
                color: AppColors.primaryColor,
                width: 1,
              ),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      //couponImage
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(coupon.couponImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 8.0, 1.0, 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(coupon.couponName, style: AppTextStyles.title),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                splitDescription[0],
                                style: AppTextStyles.normal,
                              ),
                              if (splitDescription.length > 1)
                                Text(
                                  splitDescription[1],
                                  style: AppTextStyles.normal,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(1.0, 8.0, 10.0, 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 30,
                        width: 60,
                        child: Text(coupon.points.toString()),
                      ),
                      Container(
                        height: 35,
                        child: FilledButton(
                          style: ElevatedButton.styleFrom(
                            primary: AppColors
                                .primaryColor, // This is your background color
                          ),
                          onPressed: () {
                            redeemCoupons(coupon.id, context);
                          },
                          child: Text('GET'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// void redeemConfirmation(String id) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return Theme(
//         data: Theme.of(context).copyWith(dialogBackgroundColor: AppColors.secondaryColor),
//         child: AlertDialog(
//           title: const Text('Are you sure?',
//               style: TextStyle(color: AppColors.dark)), // Set text color
//           content: Text("You will be redeeming this coupon for $points points",
//               style: TextStyle(color: AppColors.dark)), // Set text color
//           actions: <Widget>[
//             Row(children: [
//               Container(
//                 width: 150.0,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.secondaryColor,
//                   ),
//                   onPressed: () async {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text("Browse more",
//                       style:
//                           TextStyle(color: AppColors.primaryColor)), // Set text color
//                 ),
//               ),
//               Container(
//                 width: 150.0,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primaryColor,
//                   ),
//                   onPressed: () async {
//                     redeemCoupons(String id);
//                   },
//                   child: const Text("Redeem",
//                       style:
//                           TextStyle(color: Colors.white)), // Set text color
//                 ),
//               ),
//             ],)
//           ],
//         ),
//       );
//     },
//   );
// }

Future<void> redeemCoupons(String id, context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  const String redeemURL = "http://10.0.2.2:3002/api/user/redeemCoupon";
  final body = {
    "_id": id,
  };
  final redeemresponse = await http.post(
    Uri.parse(redeemURL),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    },
    body: jsonEncode(body),
  );

  if (redeemresponse.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: CustomToast(backgroundColor: AppColors.primaryColor,foregroundColor: Colors.white, message: 'Coupon redeemed', iconData: Icons.check_circle)  
          ),
        );

  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: CustomToast(backgroundColor: AppColors.error,foregroundColor: Colors.white, message: 'Unable to redeem coupon', iconData: Icons.error)
            ),
    );
  }
}
