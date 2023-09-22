import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';

class Survey {
  final String id;
  final String surveyID;
  final String surveyName;
  final String? surveyImage;
  final String surveyDescription;

  Survey({
    required this.id,
    required this.surveyID,
    required this.surveyName,
    this.surveyImage,
    required this.surveyDescription,
  });

  factory Survey.fromJson(Map<String, dynamic> json) {
    return Survey(
      id: json['_id'],
      surveyID: json['surveyID'],
      surveyName: json['surveyName'],
      surveyImage: json['surveyImage'], // This can now be null
      surveyDescription: json['surveyDescription'],
    );
  }
}

class Surveylist extends StatefulWidget {
  @override
  _SurveylistState createState() => _SurveylistState();
}

class _SurveylistState extends State<Surveylist> {
  List surveys = [];

  @override
  void initState() {
    super.initState();
    fetchSurveys();
  }

  fetchSurveys() async {
    print('fetchSurveys function called');
    var url = Uri.parse('http://10.0.2.2:3002/api/user/allsurveys');
    // var url = Uri.parse('http://localhost:3002/api/user/allsurveys');
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text('Surveys',
            style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: ListView.builder(
          itemCount: surveys.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Card(
                  elevation: 0,
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // border radius of 10
                    side: BorderSide(color: Color(0xFF6C63FF)), // border color
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width, // full width
                    height: 110, // adjust the height as needed
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          'assets/images/placeholder.jpg',
                          width: 80,
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                        // FadeInImage.assetNetwork(
                        //   placeholder: 'assets/images/placeholder.jpg',
                        //   image:'assets/images/placeholder.jpg',
                        //   width: 80,
                        //   height: 80,
                        //   fit: BoxFit.contain,
                        // ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                surveys[index].surveyName.length > 120
                                    ? '${surveys[index].surveyName.substring(0, 120)}...'
                                    : surveys[index].surveyName,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'DM-Sans'),
                              ),
                              Text(
                                surveys[index].surveyDescription,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey,
                                    fontFamily: 'DM-Sans'),
                                softWrap:
                                    true, // Breaks the text into multiple lines at word boundaries
                                // overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10), // Add space between cards
              ],
            );
          },
        ),
      ),
    );
  }
}
