import 'package:gap/gap.dart';
import 'package:http/http.dart' as http; // create class survey_form_page
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:opinion_lk/models/survey.dart';
import 'package:opinion_lk/services/survey_services.dart';
import 'package:opinion_lk/styles.dart';
// import 'package:opinion_lk/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SurveyFormPage extends StatefulWidget {
  final String surveyId;
  final String surveyName;
  final surveyPoints;

  const SurveyFormPage(
      {super.key,
      required this.surveyId,
      required this.surveyName,
      required this.surveyPoints});

  @override
  _SurveyFormPageState createState() => _SurveyFormPageState();
}

class _SurveyFormPageState extends State<SurveyFormPage> {
  late Future<Survey> futureSurvey;
  final groupValues = ValueNotifier<List<String?>>([]);
  List<TextEditingController> textControllers = [];
  Map<String, String> responses = {};
  int? get points => null;

  void submitResponses(
      String surveyId, Map<String, String> responses, int points) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    const url = 'http://10.0.2.2:3002/api/survey/createResponse';
    final data = {"responses": responses};
    final body = {
      'surveyid': surveyId,
      "response": data,
    };

    print(body);

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token}'
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      // If the response was OK, send a request to add points
      const pointsUrl = 'http://10.0.2.2:3002/api/survey/addsurveypoints';
      final pointsBody = {
        //if null then 0
        'points': points,
      };

      final pointsResponse = await http.post(
        Uri.parse(pointsUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token}'
        },
        body: jsonEncode(pointsBody),
      );

      if (pointsResponse.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Theme(
              data: Theme.of(context).copyWith(dialogBackgroundColor: AppColors.secondaryColor),
              child: AlertDialog(
                title: const Text('Points Added',
                    style: TextStyle(color: AppColors.dark)), // Set text color
                content: Text("You have earned $points points",
                    style: TextStyle(color: AppColors.dark)), // Set text color
                actions: <Widget>[
                  Container(
                    width: 150.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                      ),
                      onPressed: () async {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: const Text("Return Home",
                          style:
                              TextStyle(color: Colors.white)), // Set text color
                    ),
                  ),
                ],
              ),
            );
          },
        );
      } else {
        throw Exception('Failed to add points');
      }
    } else {
      throw Exception('Failed to submit responses');
    }
  }

  @override
  void initState() {
    super.initState();
    futureSurvey = SurveyFormService().fetchSurvey(widget.surveyId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Survey Form'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  widget.surveyName,
                  style: const TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 65,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.secondaryColor,
                  ),
                  child: Text(
                    widget.surveyPoints.toString() + ' Pts',
                    style: const TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<Survey>(
              future: futureSurvey,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  groupValues.value =
                      List.filled(snapshot.data!.questions.length, null);
                  textControllers = List.generate(
                      snapshot.data!.questions.length,
                      (index) => TextEditingController());
                  return ListView.builder(
                    itemCount: snapshot.data!.questions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data!.questions[index].question,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: snapshot
                                    .data!.questions[index].responseType ==
                                'multiplechoice'
                            ? Column(
                                children: snapshot.data!.questions[index].items!
                                    .map((item) {
                                  return ValueListenableBuilder(
                                    valueListenable: groupValues,
                                    builder: (context, value, child) {
                                      return RadioListTile<String>(
                                        title: Text(item['option']),
                                        value: item['option'],
                                        groupValue: groupValues.value[index],
                                        onChanged: (String? newValue) {
                                          groupValues.value =
                                              List.from(groupValues.value)
                                                ..[index] = newValue;
                                          responses[snapshot
                                              .data!
                                              .questions[index]
                                              .q_id] = newValue!;
                                        },
                                        activeColor: const Color(0xFF6259F5),
                                      );
                                    },
                                  );
                                }).toList(),
                              )
                            : snapshot.data!.questions[index].responseType ==
                                    'shorttext'
                                ? Column(children: [
                                    const Gap(3),
                                    TextField(
                                      controller: textControllers[index],
                                      onChanged: (String newValue) {
                                        responses[snapshot.data!
                                            .questions[index].q_id] = newValue;
                                      },
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xFF6259F5),
                                              width: 1.5), // app-purple
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xFF6259F5),
                                              width: 2.5),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        hintText: 'Enter your answer',
                                      ),
                                    ),
                                  ])
                                : null,
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
          Container(
            width: 150.0,
            child: FilledButton(
                style: ElevatedButton.styleFrom(
                  primary:
                      AppColors.primaryColor, // This is your background color
                ),
                onPressed: () {
                  submitResponses(
                      widget.surveyId, responses, widget.surveyPoints);
                },
                child: const Text("Submit")),
          ),
          const Gap(20)
        ],
      ),
    );
  }
}
