import 'package:http/http.dart' as http; // create class survey_form_page
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:opinion_lk/models/survey.dart';
import 'package:opinion_lk/services/survey_services.dart';
// import 'package:opinion_lk/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SurveyFormPage extends StatefulWidget {
  final String surveyId;
  final String surveyName;
  const SurveyFormPage({super.key, required this.surveyId, required this.surveyName});

  @override
  _SurveyFormPageState createState() => _SurveyFormPageState();
}

class _SurveyFormPageState extends State<SurveyFormPage> {
  late Future<Survey> futureSurvey;
  final groupValues = ValueNotifier<List<String?>>([]);
  List<TextEditingController> textControllers = [];
  Map<String, String> responses = {};

  void submitResponses(String surveyId, Map<String, String> responses) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    const url = 'http://10.0.2.2:3002/api/survey/createResponse';
    final body = {
      'surveyid': surveyId,
      "response": responses,
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

    if (response.statusCode != 200) {
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
        title: Text(widget.surveyName),
      ),
      body: Column(
        children: <Widget>[
          
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
                        title: Text(snapshot.data!.questions[index].question),
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
                                        activeColor: Color(0xFF6259F5),
                                      );
                                    },
                                  );
                                }).toList(),
                              )
                            : snapshot.data!.questions[index].responseType ==
                                    'shorttext'
                                ? TextField(
                                    controller: textControllers[index],
                                    onChanged: (String newValue) {
                                      responses[snapshot.data!.questions[index]
                                          .q_id] = newValue;
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
                                  )
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
          ElevatedButton(
            onPressed: () {
              submitResponses(widget.surveyId, responses);
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
