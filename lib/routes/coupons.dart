import 'package:flutter/material.dart';
import 'package:opinion_lk/routes/surveys.dart';
import 'package:opinion_lk/services/coupon_services.dart'; // Import the service
import 'package:opinion_lk/models/coupon.dart';
import 'package:opinion_lk/styles.dart'; // Import the model

class CouponsPage extends StatefulWidget {
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
                  ],),
                      
                    Padding(
                      padding: const EdgeInsets.fromLTRB(1.0, 8.0, 10.0, 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 30,
                            width: 60,
                            child:const Text("120/300"),
                          ),
                          Container(
                            height: 35,
                            child: FilledButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    AppColors.primaryColor, // This is your background color
                              ),
                              onPressed: () {},
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
