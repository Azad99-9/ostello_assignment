import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ostello/core/services/size_config.dart';
import 'package:ostello/core/services/theme_service.dart';
import 'package:ostello/features/presentation/views/lecture_screen.dart';
import 'package:ostello/features/presentation/widgets/custom_text_field.dart';

class AskQuestionState extends ConsumerWidget {
  const AskQuestionState(
      {super.key,
      required this.questionController,
      required this.descriptionController});

  final TextEditingController questionController;
  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  ref.read(newQuestionProvider.notifier).state = false;
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
                'New Question',
                style: ThemeService.labelMedium.copyWith(fontSize: 18),
              ),
              Spacer(
                flex: 3,
              ),
            ],
          ),
        ),
        Divider(
          color: ThemeService.secondaryColor.withOpacity(0.2),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 2,
        ),
        Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(4),
          width: double.infinity,
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Text(
            '27. Algebra 12: Functions 4 Trignometry',
            style:
                ThemeService.titleMedium.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 2,
        ),
        CustomTextField(
            hintText: 'Question Title', controller: questionController),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 2,
        ),
        CustomTextField(hintText: 'Details', controller: descriptionController),
      ],
    );
  }
}
