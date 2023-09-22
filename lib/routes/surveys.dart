import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Survey {
  final String id;
  final String surveyID;
  final String surveyName;
  final String surveyImage;
  final String surveyDescription;

  Survey({
    required this.id,
    required this.surveyID,
    required this.surveyName,
    required this.surveyImage,
    required this.surveyDescription,
  });

  factory Survey.fromJson(Map<String, dynamic> json) {
    return Survey(
      id: json['_id'],
      surveyID: json['surveyID'],
      surveyName: json['surveyName'],
      surveyImage: json['surveyImage'],
      surveyDescription: json['surveyDescription'],
    );
  }
}


class Surveys extends StatefulWidget {
  @override
  _SurveysState createState() => _SurveysState();
}

class _SurveysState extends State<Surveys> {
  List surveys = [];

  @override
  void initState() {
    super.initState();
    fetchSurveys();
  }

  fetchSurveys() async {
    var url = Uri.parse('http://10.0.2.2:3002/api/user/allsurveys');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        surveys = data.map((item) => Survey.fromJson(item)).toList();
      });
    } else {
      setState(() {
        surveys = ['error'];
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: surveys.isEmpty
          ? Text('No surveys found.')
          : ListView.builder(
              itemCount: surveys.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 0,
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // border radius of 10
                    side: BorderSide(color: Color(0xFF6C63FF)), // border color
                  ),
                  child: SizedBox(
                    width: 200,
                    height: 400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        // Image.network(surveys[index].surveyImage), // survey image
                        Text(
                          surveys[index].surveyName, // survey name
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'DM-Sans'),
                        ),
                        Text(
                          surveys[index].surveyDescription, // survey description
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                            fontFamily: 'DM-Sans'),
                        ),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF6C63FF), // button color
                            onPrimary: Colors.white, // text color
                            padding:
                                EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          ),
                          onPressed: () {},
                          child: Text('Take Survey'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
