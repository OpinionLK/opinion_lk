import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:opinion_lk/models/coupon.dart'; // Assuming you have a Coupon model

class CouponService {
  final String apiUrl = "http://10.0.2.2:3002/api/user/getAllCoupons";

  Future<List<Coupon>> fetchCoupons() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => Coupon.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load coupons from API');
    }
  }
}
