import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ostello/features/questions/domain/question.dart';
import 'package:ostello/features/questions/domain/question_repository.dart';
import 'package:ostello/providers/firestore_provider.dart';

class QuestionViewModel extends StateNotifier<AsyncValue<List<Question>>> {
  final QuestionRepository repository;

  // Constructor initializes with the repository and a loading state
  QuestionViewModel(this.repository) : super(const AsyncValue.loading());

  // Method to add a question, and returns the newly added question
  Future<void> addQuestion(Question question) async {
    state = const AsyncValue.loading();
    try {
      // Add the question to the repository
      final newQuestion = await repository.addQuestion(question);
      // After adding, you could optionally update the list of questions here if needed
      state = AsyncValue.data([newQuestion]);  // Example: returning the list of added question(s)
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  // Method to fetch all questions
  Future<void> fetchQuestions() async {
    state = const AsyncValue.loading();
    try {
      // Fetch the list of questions from the repository
      final questions = await repository.fetchQuestions();
      state = AsyncValue.data(questions);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}