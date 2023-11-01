import 'dart:convert';

Coupon CouponFromJson(String str) => Coupon.fromJson(json.decode(str));

String CouponToJson(Coupon data) => json.encode(data.toJson());

class Coupon {
  final String id;
  final String couponName;
  final String couponCode;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final String companyName;
  final int points;
  final int count;
  final String couponImage;

  Coupon({
    required this.id,
    required this.couponName,
    required this.couponCode,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.companyName,
    required this.points,
    required this.count,
    required this.couponImage,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json['_id'],
      couponName: json['CouponName'],
      couponCode: json['CouponCode'],
      description: json['Description'],
      startDate: DateTime.parse(json['StartDate']),
      endDate: DateTime.parse(json['EndDate']),
      status: json['Status'],
      companyName: json['CompanyName'],
      points: int.parse(json['Points']),
      count: json['Count'],
      couponImage: json['CouponImage'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'CouponName': couponName,
      'CouponCode': couponCode,
      'Description': description,
      'StartDate': startDate.toIso8601String(),
      'EndDate': endDate.toIso8601String(),
      'Status': status,
      'CompanyName': companyName,
      'Points': points.toString(),
      'Count': count,
      'CouponImage': couponImage,
    };
  }
}
