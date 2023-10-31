class Question {
  final String question;
  final String q_id;
  final String responseType;
  final List<Map<String, dynamic>>? items;

  Question({required this.question, required this.q_id, required this.responseType, required this.items});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
      q_id:json['questionID'],
      responseType: json['responseType'],
      items: json['items'] != null ? List<Map<String, dynamic>>.from(json['items']) : null,
    );
  }
}