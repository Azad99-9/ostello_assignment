import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ostello/features/answers/domain/answer.dart';
import 'package:ostello/features/answers/domain/answer_repository.dart';

class AnswerRepositoryImpl implements AnswerRepository {
  final FirebaseFirestore firestore;

  AnswerRepositoryImpl(this.firestore);

  @override
  Future<Answer> addAnswer(Answer answer) async {
    // Add the answer to Firestore
    final docRef =
        await firestore.collection('answers').add(answer.toFirestore());

    // Fetch the added document data
    final docSnapshot = await docRef.get();

    // Convert the snapshot data into an Answer object and add the document ID
    final newAnswer = Answer.fromFirestore(docSnapshot.id, docSnapshot.data()!);

    return newAnswer;
  }

  @override
  Future<List<Answer>> fetchAnswers(String questionId) async {
    final querySnapshot = await firestore
        .collection('answers')
        .where('questionId', isEqualTo: questionId)
        .get();
    return querySnapshot.docs
        .map((doc) => Answer.fromFirestore(doc.id, doc.data()))
        .toList();
  }
}
