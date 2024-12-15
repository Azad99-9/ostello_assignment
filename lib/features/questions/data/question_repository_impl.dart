import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ostello/features/questions/domain/question.dart';
import 'package:ostello/features/questions/domain/question_repository.dart';

class QuestionRepositoryImpl implements QuestionRepository {
  final FirebaseFirestore firestore;

  QuestionRepositoryImpl(this.firestore);

  @override
  Future<Question> addQuestion(Question question) async {
    // Add the question to Firestore
    final docRef =
        await firestore.collection('questions').add(question.toFirestore());

    // Create a new Question object with the document ID (Firestore auto-generates it)
    final docSnapshot = await docRef.get();

    final newQuestion =
        Question.fromFirestore(docSnapshot.id, docSnapshot.data()!);

    return newQuestion; // Return the newly added Question object with the Firestore ID
  }

  @override
  Future<List<Question>> fetchQuestions() async {
    final querySnapshot = await firestore.collection('questions').get();
    return querySnapshot.docs
        .map((doc) => Question.fromFirestore(doc.id, doc.data()))
        .toList();
  }

  @override
  Future<void> updateQuestion(String questionId, Map<String, dynamic> updatedFields) async {
    try {
      await firestore
          .collection('questions')
          .doc(questionId)
          .update(updatedFields);
    } catch (e) {
      throw Exception('Error updating question: $e');
    }
  }
}
