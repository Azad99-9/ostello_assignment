import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ostello/features/answers/domain/answer.dart';
import 'package:ostello/features/answers/domain/answer_repository.dart';
import 'package:ostello/features/questions/domain/question.dart';
import 'package:ostello/features/questions/domain/question_repository.dart';
import 'package:ostello/features/threads/domain/thread.dart';
import 'package:ostello/features/threads/domain/thread_repository.dart';

class ThreadViewModel extends StateNotifier<AsyncValue<Thread?>> {
  final ThreadRepository threadRepository;
  final AnswerRepository answerRepository;
  final QuestionRepository questionRepository;

  ThreadViewModel(
      {required this.threadRepository,
      required this.answerRepository,
      required this.questionRepository})
      : super(const AsyncValue.loading());

  // Fetch threads by questionId
  Future<void> fetchThread(String questionId) async {
    state = const AsyncValue.loading();
    try {
      Thread? thread = await threadRepository.getThreadByQuestionId(questionId);

      state =
          AsyncValue.data(thread); // Update threads and set loading to false
    } catch (e, stack) {
      state = AsyncValue.error(e, stack); // Handle error
    }
  }

  // Update an existing thread
  Future<void> updateThreadByQuestionId(String questionId,
      {Question? question, List<Answer>? answers}) async {
    try {
      final thread = await threadRepository.getThreadByQuestionId(questionId);
      if (answers != null) {
        for (var answer in answers) {
          final newAnswer = await answerRepository.addAnswer(answer);
          thread?.answerIds.add(newAnswer.id!);
        }
        questionRepository
            .updateQuestion(questionId, {'repliesCount': thread!.answerIds.length});
      }
      await threadRepository.updateThread(thread?.id ?? '', thread!);
      state = AsyncValue.data(thread);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack); // Handle error
      throw('error');
    }
  }
}
