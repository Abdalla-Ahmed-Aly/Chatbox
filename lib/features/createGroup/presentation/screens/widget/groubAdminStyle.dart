import 'package:chatbox/core/widget/OnlineAvatar.dart';
import 'package:chatbox/features/chat/presentation/screens/widget/resiver/continerCusomeResiver.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_theme.dart';

class Groubadminstyle extends StatelessWidget {
  final String Name;

  const Groubadminstyle({required this.Name});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Continercusomeresiver(
      imagePath: 'assets/images/model1.png',
      isOnline: false,
      radius: 30,
      messageContent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Name,
            style: textTheme.bodyLarge!.copyWith(
              color: AppTheme.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Group Admin',
            style: textTheme.bodySmall!.copyWith(
              color: AppTheme.gray,
              fontWeight: FontWeight.bold,
            ),
          ),
         
        ],
      ),
    );
  }
}
