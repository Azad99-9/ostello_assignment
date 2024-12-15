import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  late final String? id;
  final String question;
  final String description;
  final String raisedBy;
  final int repliesCount;
  final DateTime raiseTime;
  final int lecNumber;
  late final String? threadId;

  Question({
    this.id,
    required this.question,
    required this.description,
    required this.raisedBy,
    required this.repliesCount,
    required this.raiseTime,
    required this.lecNumber,
    this.threadId,
  });

  factory Question.fromFirestore(String id, Map<String, dynamic> data) {
    return Question(
      id: id,
      question: data['question'],
      description: data['description'],
      raisedBy: data['raisedBy'],
      repliesCount: data['repliesCount'] ?? 0,
      raiseTime: (data['raiseTime'] as Timestamp).toDate(),
      lecNumber: data['lecNumber'],
      threadId: data['threadId'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'question': question,
      'description': description,
      'raisedBy': raisedBy,
      'repliesCount': repliesCount,
      'raiseTime': raiseTime,
      'lecNumber': lecNumber,
      'threadId': threadId,
    };
  }
}