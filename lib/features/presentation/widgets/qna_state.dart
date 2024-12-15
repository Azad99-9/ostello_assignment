import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ostello/core/services/theme_service.dart';
import 'package:ostello/features/presentation/views/lecture_screen.dart';
import 'package:ostello/features/presentation/widgets/question_card.dart';
import 'package:ostello/providers/firestore_provider.dart';

class QnaState extends ConsumerWidget {
  const QnaState({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionState = ref.watch(questionsProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Sample Video Title",
            style: ThemeService.titleLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "Most shocking news Most shocking Most shocking news ..More",
            style: ThemeService.titleMedium,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ActionButton(
                  iconData: Icons.chat_bubble_outline,
                  iconTitle: 'Chats',
                ),
                ActionButton(
                  iconData: Icons.mark_chat_read_outlined,
                  iconTitle: 'Doubts',
                  isSelected: true,
                  
                ),
                ActionButton(
                  iconData: Icons.menu_book,
                  iconTitle: 'Notes',
                ),
                ActionButton(
                  iconData: Icons.monetization_on_outlined,
                  iconTitle: 'Rewards',
                ),
              ],
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Q&A',
                style: ThemeService.labelMedium.copyWith(fontSize: 18),
              ),
              TextButton(
                onPressed: () {
                  ref.read(seeAllProvider.notifier).state = !ref.read(seeAllProvider.notifier).state;
                },
                child: Text(
                  'See all',
                  style: ThemeService.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ThemeService.primaryColor,
                  ),
                ),
              )
            ],
          ),
        ),

        questionState.when(data: (questions) {
          final displayQuestions = questions.take(3).toList();
          return Column(
            children: List.generate(displayQuestions.length,
                (index) => QuestionCard(question: displayQuestions[index])),
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
