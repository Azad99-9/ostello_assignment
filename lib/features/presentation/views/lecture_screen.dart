import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ostello/core/services/size_config.dart';
import 'package:ostello/core/services/theme_service.dart';
import 'package:ostello/features/answers/domain/answer.dart';
import 'package:ostello/features/presentation/widgets/ask_question_state.dart';
import 'package:ostello/features/presentation/widgets/qna_state.dart';
import 'package:ostello/features/presentation/widgets/question_card.dart';
import 'package:ostello/features/presentation/widgets/show_all_questions.dart';
import 'package:ostello/features/questions/domain/question.dart';
import 'package:ostello/providers/firestore_provider.dart';

final seeAllProvider = StateProvider<bool>((ref) => false);
final newQuestionProvider = StateProvider<bool>((ref) => false);

class LectureScreen extends ConsumerWidget {
  LectureScreen({super.key});

  final TextEditingController _threadTextController = TextEditingController();
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seeAll = ref.watch<bool>(seeAllProvider);
    final questionId = ref.watch<String?>(questionIdProvider);
    final newQuestion = ref.watch<bool>(newQuestionProvider);
    ref.invalidate(questionsProvider);
    // final threadViewModel = ref.watch<ThreadViewModel>(threadRepositoryProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video/Image section
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset(
                    'assets/images/video_place_holder.png', // Replace with your image URL
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),

            (seeAll || questionId != null) && !newQuestion
                ? const ShowAllQuestions()
                : newQuestion
                    ? AskQuestionState(
                        questionController: _questionController,
                        descriptionController: _descriptionController,
                      )
                    : const QnaState(),

            // newQuestion && !seeAll && (questionId == null)
            // ? AskQuestionState(
            //     questionController: _questionController,
            //     descriptionController: _descriptionController,
            //   )
            //     : Container(),
            // !newQuestion && !seeAll && (questionId == null)
            //     ? const QnaState()
            //     : Container(),
            // !newQuestion ? const ShowAllQuestions() : Container(),
            // AskQuestionState(),
            const SizedBox(
              height: 100,
            ),
            // Suggested videos
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: questionId == null
          ? FloatingActionButton.extended(
              backgroundColor: ThemeService.surfaceColor,
              shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              elevation: 0,
              onPressed: () async {
                if (!newQuestion) {
                  ref.read(newQuestionProvider.notifier).state = true;
                } else {
                  await ref.read(questionRepositoryProvider).addQuestion(
                        Question(
                          question: _questionController.text,
                          description: _descriptionController.text,
                          lecNumber: 1,
                          raiseTime: DateTime.now(),
                          raisedBy: 'John',
                          repliesCount: 0,
                        ),
                      );
                  ref.read(newQuestionProvider.notifier).state = false;
                }
              },
              label: Container(
                width: SizeConfig.screenWidth * 0.7,
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0), // Horizontal padding of 10px
                child: Text(
                  newQuestion ? 'Submit' : 'Ask a question',
                  style: ThemeService.labelMedium, // Apply your desired style
                  textAlign:
                      TextAlign.center, // Center the text inside the label
                ),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: SizeConfig.blockSizeHorizontal * 80,
                  decoration: BoxDecoration(
                    color: ThemeService.surfaceColor, // Background color
                    border: Border.all(color: Colors.black), // Border color
                    borderRadius: const BorderRadius.all(
                        Radius.circular(10)), // Rounded corners
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0), // Internal padding
                  child: TextField(
                    controller: _threadTextController,
                    decoration: InputDecoration(
                      hintText: 'Write a reply',
                      hintStyle: ThemeService
                          .labelMedium, // Apply the desired text style
                      border: InputBorder.none, // Remove the default underline
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 14.0), // Vertical padding for text area
                    ),
                    textAlign: TextAlign.start, // Center the text
                    style: ThemeService.labelMedium,
                    // Text style for user input
                  ),
                ),
                InkWell(
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    await ref
                        .read(threadViewModelProvider)
                        .updateThreadByQuestionId(
                      questionId,
                      answers: [
                        Answer(
                          description: _threadTextController.text,
                          answeredBy: 'John',
                          answerTime: DateTime.now(),
                        ),
                      ],
                    );
                  },
                  child: CircleAvatar(
                    radius: SizeConfig.blockSizeHorizontal * 7,
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.send_outlined,
                      color: ThemeService.surfaceColor,
                      size: SizeConfig.blockSizeHorizontal * 6,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton(
      {super.key,
      required this.iconData,
      required this.iconTitle,
      this.isSelected = false});

  final IconData iconData;
  final String iconTitle;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ElevatedButton(
        onPressed: () {
          // Define the button's action
        },
        style: ButtonStyle(
          elevation: WidgetStatePropertyAll(0),
          backgroundColor: WidgetStateProperty.all(isSelected
              ? ThemeService.primaryAccent.withOpacity(0.3)
              : ThemeService.secondaryAccent),
          foregroundColor: WidgetStateProperty.all<Color>(isSelected
              ? ThemeService.primaryColor
              : ThemeService.secondaryColor),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(iconData, size: isSelected ? 20 : 18.0),
            SizedBox(width: 8.0),
            Text(
              iconTitle,
              style: ThemeService.titleMedium.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
