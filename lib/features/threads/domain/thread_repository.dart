import 'package:ostello/features/threads/domain/thread.dart';

abstract class ThreadRepository {
  Future<Thread?> getThreadByQuestionId(String? questionId);
  Future<void> updateThread(String threadId, Thread thread);
}
