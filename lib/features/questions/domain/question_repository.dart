import 'package:ostello/features/questions/domain/question.dart';

abstract class QuestionRepository {
  Future<Question> addQuestion(Question question);
  Future<List<Question>> fetchQuestions();
  Future<void> updateQuestion(String questionId, Map<String, dynamic> updatedFields);
}