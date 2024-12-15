import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ostello/core/services/size_config.dart';
import 'package:ostello/core/services/theme_service.dart';
import 'package:ostello/features/presentation/views/lecture_screen.dart';
import 'package:ostello/features/presentation/widgets/question_card.dart';
import 'package:ostello/features/presentation/widgets/thread_components.dart';
import 'package:ostello/features/questions/domain/question.dart';
import 'package:ostello/features/threads/domain/thread.dart';
import 'package:ostello/providers/firestore_provider.dart';

class ShowAllQuestions extends ConsumerWidget {
  const ShowAllQuestions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Question>> questionState =
        ref.watch(questionsProvider);
    final String? questionId = ref.watch(questionIdProvider);
    final AsyncValue<Thread?> threadState =
        ref.watch(threadsProvider(questionId));
    ref.invalidate(threadsProvider(questionId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Row(
            children: [
              questionId != null
                  ? InkWell(
                      onTap: () {
                        ref.read(questionIdProvider.notifier).state = null;
                      },
                      child: Text(
                        'Back',
                        style: ThemeService.bodySmall
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        ref.read(seeAllProvider.notifier).state = false;
                      },
                      child: Text(
                        'Cancel',
                        style: ThemeService.bodySmall
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
              Spacer(
                flex: 2,
              ),
              Text(
                'Questions',
                style: ThemeService.labelMedium.copyWith(fontSize: 18),
              ),
              Spacer(
                flex: 3,
              ),
            ],
          ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 2,
        ),
        questionId != null
            ? threadState.when(data: (thread) {
                return Column(
                  children:
                      <Widget>[ThreadQuestion(question: thread!.question!)] +
                          List.generate(
                            thread.answerIds.length,
                            (index) => ThreadAnswer(
                              answer: thread.answers![index],
                            ),
                          ),
                );
              }, error: (e, s) {
                return Container(
                  child: Text(
                    s.toString(),
                  ),
                );
              }, loading: () {
                return const Center(child: CircularProgressIndicator());
              })
            : questionState.when(data: (questions) {
                return Column(
                  children: List.generate(questions.length,
                      (index) => QuestionCard(question: questions[index])),
                );
              }, error: (e, s) {
                return Container();
              }, loading: () {
                return const Center(child: CircularProgressIndicator());
              }),
      ],
    );
  }
}
