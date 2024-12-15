import 'package:ostello/features/answers/domain/answer.dart';

abstract class AnswerRepository {
  Future<Answer> addAnswer(Answer answer);
  Future<List<Answer>> fetchAnswers(String questionId);
}