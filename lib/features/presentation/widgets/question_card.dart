import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ostello/core/services/size_config.dart';
import 'package:ostello/core/services/theme_service.dart';
import 'package:ostello/features/questions/domain/question.dart';
import 'package:ostello/features/threads/domain/thread.dart';
import 'package:ostello/providers/firestore_provider.dart';

final StateProvider<String?> questionIdProvider = StateProvider<String?>((ref) => null);

class QuestionCard extends ConsumerWidget {
  const QuestionCard({
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
                  image: NetworkImage('https://plus.unsplash.com/premium_photo-1671656349322-41de944d259b?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D'),
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
                    '@${question.raisedBy}',
                    style: ThemeService.bodySmall
                        .copyWith(color: Color(0xff7d7d7d)),
                  ),
                  const SizedBox(height: 4),
                  // Q'uestion
                  Text(
                    question.question,
                    style: ThemeService.bodyMedium
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // Answer
                  Text(
                    question.description,
                    style: ThemeService.bodyMedium
                        .copyWith(color: Color(0xff7c7c7c),),
                  ),
                  const SizedBox(height: 8),
                  // Replies
                  Row(
                    children: [
                      
                      InkWell(
                        onTap: () async {
                          ref.read(questionIdProvider.notifier).state = question.id;
                        },
                        child: Text(
                          '${question.repliesCount} Replies',
                          style: ThemeService.bodySmall.copyWith(color: ThemeService.primaryColor)
                        ),
                      ),
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
