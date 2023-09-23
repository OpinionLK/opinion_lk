import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:opinion_lk/models/survey.dart';

class SurveyService {
  static const String _baseUrl = 'http://10.0.2.2:3002/api/user/allsurveys';

  Future<List<Survey>> fetchSurveys() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => Survey.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load surveys');
    }
  }
}
