import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ostello/core/services/size_config.dart';
import 'package:ostello/core/services/theme_service.dart';
import 'package:ostello/features/answers/domain/answer.dart';
import 'package:ostello/features/questions/domain/question.dart';

class ThreadQuestion extends ConsumerWidget {
  const ThreadQuestion({
    super.key,
    required this.question,
  });

  final Question question;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: ThemeService.surfaceColor,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 2:8 Ratio Part 1: CircleAvatar
            Container(
              width: SizeConfig.blockSizeHorizontal * 15, // 2 parts
              height: SizeConfig.blockSizeHorizontal * 15, // 2 parts
              margin: const EdgeInsets.only(right: 16.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                      'https://plus.unsplash.com/premium_photo-1671656349322-41de944d259b?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // 2:8 Ratio Part 2: Column with details
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name

                  Text(
                    question.question,
                    style: ThemeService.bodyMedium
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // Answer
                  Text(
                    question.description,
                    style: ThemeService.bodyMedium.copyWith(
                      color: Color(0xff7c7c7c),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Replies
                  Row(
                    children: [
                      Text(
                        question.raisedBy,
                        style: ThemeService.bodyMedium
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '   ${DateFormat('d MMM y')
                            .format(question.raiseTime)}'
                            ,
                        style: ThemeService.bodyMedium.copyWith(
                          color: Color(0xff7c7c7c),
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThreadAnswer extends ConsumerWidget {
  const ThreadAnswer({
    super.key,
    required this.answer,
  });

  final Answer answer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: ThemeService.surfaceColor,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 2:8 Ratio Part 1: CircleAvatar
            Container(
              width: SizeConfig.blockSizeHorizontal * 15, // 2 parts
              height: SizeConfig.blockSizeHorizontal * 15, // 2 parts
              margin: const EdgeInsets.only(right: 16.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                      'https://plus.unsplash.com/premium_photo-1671656349322-41de944d259b?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // 2:8 Ratio Part 2: Column with details
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  // Answer
                  Text(
                    answer.description,
                    style: ThemeService.bodyMedium.copyWith(
                      color: Color(0xff7c7c7c),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Replies
                  Row(
                    children: [
                      Text(
                        answer.answeredBy,
                        style: ThemeService.bodyMedium
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '   ${DateFormat('d MMM y')
                            .format(answer.answerTime)}',
                        style: ThemeService.bodyMedium.copyWith(
                          color: Color(0xff7c7c7c),
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
