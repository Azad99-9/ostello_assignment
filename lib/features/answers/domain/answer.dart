import 'package:cloud_firestore/cloud_firestore.dart';

class Answer {
  late final String? id;
  final String description;
  final String answeredBy;
  final DateTime answerTime;

  Answer({
    this.id,
    required this.description,
    required this.answeredBy,
    required this.answerTime,
  });

  factory Answer.fromFirestore(String id, Map<String, dynamic> data) {
    return Answer(
      id: id,
      description: data['description'],
      answeredBy: data['answeredBy'],
      answerTime: (data['answerTime'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'description': description,
      'answeredBy': answeredBy,
      'answerTime': answerTime,
    };
  }
}