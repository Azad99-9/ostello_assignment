import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ostello/features/answers/domain/answer.dart';
import 'package:ostello/features/questions/domain/question.dart';
import 'package:ostello/features/threads/domain/thread.dart';
import 'package:ostello/features/threads/domain/thread_repository.dart';

class ThreadRepositoryImpl implements ThreadRepository {
  final FirebaseFirestore _firestore;

  ThreadRepositoryImpl(this._firestore);

  @override
  Future<Thread?> getThreadByQuestionId(String? questionId) async {
    if (questionId == null) return null;
    try {
      // Fetch the thread document
      QuerySnapshot snapshot = await _firestore
          .collection('threads')
          .where('questionId', isEqualTo: questionId)
          .get();

      late final Thread thread;
      if (snapshot.docs.isEmpty) {
        await _firestore
            .collection('threads')
            .add({'questionId': questionId, 'answerIds': []});
        thread = Thread(
          questionId: questionId,
          answerIds: [],
        );
      } else {
        var threadData = snapshot.docs.first.data() as Map<String, dynamic>;
        thread = Thread.fromFirestore(snapshot.docs.first.id, threadData);
      }
      // Parse the thread data

      // Fetch the related question using the questionId from the thread
      DocumentSnapshot questionDoc =
          await _firestore.collection('questions').doc(thread.questionId).get();

      Question? question;
      if (questionDoc.exists) {
        final data = questionDoc.data() as Map<String, dynamic>;
        question = Question.fromFirestore(questionDoc.id, data);
      }

      // Fetch the related answers using the answerIds from the thread
      List<Answer> answers = [];
      for (var answerId in thread.answerIds) {
        DocumentSnapshot answerDoc =
            await _firestore.collection('answers').doc(answerId).get();

        if (answerDoc.exists) {
          var answer = Answer.fromFirestore(
              answerDoc.id, answerDoc.data() as Map<String, dynamic>);
          answers.add(answer);
        }
      }

      // Return the thread with the fetched question and answers
      return thread.copyWith(question: question, answers: answers);
    } catch (e) {
      throw Exception('Error fetching thread: $e');
    }
  }

  @override
  Future<void> updateThread(String threadId, Thread thread) async {
    try {
      await _firestore
          .collection('threads')
          .doc(threadId)
          .update(thread.toFirestore());
    } catch (e) {
      throw Exception('Error updating thread: $e');
    }
  }
}
