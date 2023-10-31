// To parse this JSON data, do
//
//     final Survey = SurveyFromJson(jsonString);

import 'dart:convert';

import 'package:opinion_lk/models/question.dart';
// import 'package:opinion_lk/routes/survey_form_page.dart';

Survey SurveyFromJson(String str) => Survey.fromJson(json.decode(str));

String SurveyToJson(Survey data) => json.encode(data.toJson());

class Survey {
    String id;
    String surveyId;
    String surveyName;
    String surveyImage;
    String surveyDescription;
    String creatorId;
    String approvalStatus;
    List<dynamic> tags;
    List<Question> questions;
    DateTime createdDate;
    List<dynamic> responses;
    List<dynamic> comments;
    // DateTime createdAt;
    // DateTime updatedAt;
    int v;

    Survey({
        required this.id,
        required this.surveyId,
        required this.surveyName,
        required this.surveyImage,
        required this.surveyDescription,
        required this.creatorId,
        required this.approvalStatus,
        required this.tags,
        required this.questions,
        required this.createdDate,
        required this.responses,
        required this.comments,
        // required this.createdAt,
        // required this.updatedAt,
        required this.v,
    });

    factory Survey.fromJson(Map<String, dynamic> json) => Survey(
        id: json["_id"],
        surveyId: json["surveyID"],
        surveyName: json["surveyName"],
        surveyImage: json["surveyImage"],
        surveyDescription: json["surveyDescription"],
        creatorId: json["creatorID"],
        approvalStatus: json["approvalStatus"],
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        questions: (json['questions'] as List)
          .map((questionJson) => Question.fromJson(questionJson))
          .toList(),
        createdDate: DateTime.parse(json["created_date"]),
        responses: List<dynamic>.from(json["responses"].map((x) => x)),
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        // createdAt: DateTime.parse(json["createdAt"]),
        // updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "surveyID": surveyId,
        "surveyName": surveyName,
        "surveyImage": surveyImage,
        "surveyDescription": surveyDescription,
        "creatorID": creatorId,
        "approvalStatus": approvalStatus,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "questions": List<dynamic>.from(questions.map((x) => x)),
        "created_date": createdDate.toIso8601String(),
        "responses": List<dynamic>.from(responses.map((x) => x)),
        "comments": List<dynamic>.from(comments.map((x) => x)),
        // "createdAt": createdAt.toIso8601String(),
        // "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };

    
}
