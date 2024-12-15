import 'package:ostello/features/answers/domain/answer.dart';
import 'package:ostello/features/questions/domain/question.dart';

class Thread {
  final String? id;
  final String questionId;
  final List<String>
      answerIds; // This can be used to store answer IDs for reference
  final Question?
      question; // The actual Question object associated with this thread
  final List<Answer>? answers; // The actual answers associated with the thread

  Thread({
    this.question,
    this.id,
    required this.answerIds,
    required this.questionId,
    this.answers,
  });

  // The `copyWith` method allows for updating any of the fields, including the question and answers
  Thread copyWith({
    String? id,
    String? questionId,
    List<String>? answerIds,
    Question? question,
    List<Answer>? answers,
  }) {
    return Thread(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      answerIds: answerIds ?? this.answerIds,
      question: question ?? this.question,
      answers: answers ?? this.answers,
    );
  }

  // Factory constructor to create a Thread from Firestore data
  factory Thread.fromFirestore(String id, Map<String, dynamic> data) {
    return Thread(
      id: id,
      questionId: data['questionId'],
      answerIds: List<String>.from(
          data['answerIds'] ?? []), // Assume 'answerIds' is a list of strings
    );
  }

  // Method to convert the Thread to Firestore-compatible format
  Map<String, dynamic> toFirestore() {
    return {
      'questionId': questionId,
      'answerIds': answerIds, // List of answer IDs for reference
    };
  }
}
