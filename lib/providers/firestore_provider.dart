import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ostello/features/answers/data/answer_repository_impl.dart';
import 'package:ostello/features/answers/domain/answer.dart';
import 'package:ostello/features/answers/domain/answer_repository.dart';
import 'package:ostello/features/presentation/view_models/thread_viewmodel.dart';
import 'package:ostello/features/questions/data/question_repository_impl.dart';
import 'package:ostello/features/questions/domain/question.dart';
import 'package:ostello/features/questions/domain/question_repository.dart';
import 'package:ostello/features/threads/data/thread_repository_impl.dart';
import 'package:ostello/features/threads/domain/thread.dart';
import 'package:ostello/features/threads/domain/thread_repository.dart';

final firestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final questionRepositoryProvider = Provider<QuestionRepository>(
    (ref) => QuestionRepositoryImpl(ref.read(firestoreProvider)));

final answerRepositoryProvider = Provider<AnswerRepository>(
    (ref) => AnswerRepositoryImpl(ref.read(firestoreProvider)));

final threadRepositoryProvider = Provider<ThreadRepository>(
    (ref) => ThreadRepositoryImpl(ref.read(firestoreProvider)));

final questionsProvider = FutureProvider<List<Question>>((ref) {
  return ref.read(questionRepositoryProvider).fetchQuestions();
});

final threadViewModelProvider = StateProvider<ThreadViewModel>((ref) {
  return ThreadViewModel(threadRepository: ref.read(threadRepositoryProvider), answerRepository: ref.read(answerRepositoryProvider), questionRepository: ref.read(questionRepositoryProvider));
});

final answersProvider =
    FutureProvider.family<List<Answer>, String>((ref, questionId) {
  return ref.read(answerRepositoryProvider).fetchAnswers(questionId);
});

final threadsProvider =
    FutureProvider.family<Thread?, String?>((ref, questionId) async {
  return ref.read(threadRepositoryProvider).getThreadByQuestionId(questionId);
});
