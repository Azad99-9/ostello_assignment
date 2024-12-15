import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ostello/features/answers/domain/answer.dart';
import 'package:ostello/features/answers/domain/answer_repository.dart';

class AnswerViewModel extends StateNotifier<List<Answer>> {
  final AnswerRepository _answerRepository;

  AnswerViewModel(this._answerRepository) : super([]);

  // Fetch answers for a specific question
  Future<void> fetchAnswers(String questionId) async {
    try {
      final answers = await _answerRepository.fetchAnswers(questionId);
      state = answers;
    } catch (e) {
      // Handle error (log or display message)
      state = [];
    }
  }

  // Add a new answer
  Future<void> addAnswer(Answer answer) async {
    try {
      final newAnswer = await _answerRepository.addAnswer(
        answer,
      );
      state = [...state, newAnswer]; // Update state with new answer
    } catch (e) {
      // Handle error (log or display message)
    }
  }
}
