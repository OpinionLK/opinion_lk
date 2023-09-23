import 'package:flutter/material.dart';
import 'package:opinion_lk/models/survey.dart';
import 'package:opinion_lk/services/survey_services.dart';
import 'package:opinion_lk/styles.dart';

class SurveysPage extends StatefulWidget {
  @override
  _SurveysPageState createState() => _SurveysPageState();
}

class _SurveysPageState extends State<SurveysPage> {
  late Future<List<Survey>> futureSurveys;

  @override
  void initState() {
    super.initState();
    futureSurveys = SurveyService().fetchSurveys();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Surveys'),
      ),
      body: Center(
        child: FutureBuilder<List<Survey>>(
          future: futureSurveys,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return SurveyCard(survey: snapshot.data![index]);
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class SurveyCard extends StatelessWidget {
  final Survey survey;

  const SurveyCard({required this.survey});
  
  @override
  Widget build(BuildContext context) {
    String surveyDescription = survey.surveyDescription;
    List<String> splitDescription = splitIntoLines(surveyDescription, 44);
    return Center(
      // padding: const EdgeInsets.all(8),
      child: Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: AppColors.primaryColor,
            width: 1,
            // color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container( // image container
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    image: DecorationImage(
                      image: NetworkImage('https://ik.imagekit.io/7i3fql4kv7/survey_headers/alice-donovan-rouse-yu68fUQDvOI-unsplash.jpg'),
                      // image: NetworkImage('http://10.0.2.2:3002//api/survey/images/placeholder'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(  // text container
                  padding: const EdgeInsets.fromLTRB(5.0, 8.0, 1.0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(survey.surveyName, style: AppTextStyles.title),
                      // Text(survey.surveyDescription, style: AppTextStyles.normal),
                      Column(
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
              SizedBox( // points container  
                width: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Text(survey.surveyPoints.toString()), 
                    // const Text('69'),
                    // save icon
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.navigate_next),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}

List<String> splitIntoLines(String text, int maxLength) {
  List<String> lines = [];
  while (text.length > maxLength) {
    int index = text.lastIndexOf(' ', maxLength);
    lines.add(text.substring(0, index));
    text = text.substring(index + 1);
  }
  lines.add(text);
  return lines;
}
