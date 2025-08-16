import 'dart:io';

import 'package:chatbox/features/chat/presentation/screens/widget/sender/playRecordSender.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_theme.dart';

class SenderMessage extends StatelessWidget {
  final String? audioPath;
  final String? imagePath;
  final String? text;

  const SenderMessage({this.audioPath, this.imagePath, this.text});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    Widget messageContent;

    if (imagePath != null) {
      messageContent = GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => Dialog(
              backgroundColor: Colors.transparent,
              child: InteractiveViewer(
                child: Image.file(File(imagePath!), fit: BoxFit.contain),
              ),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
            File(imagePath!),
            fit: BoxFit.cover,
            width: 150,
            height: 160,
          ),
        ),
      );
    } else if (audioPath != null) {
      messageContent = Playrecordsender(audioPath: audioPath!);
    } else {
      messageContent = Text(
        text ?? 'ss',
        style: textTheme.bodyMedium!.copyWith(color: Colors.white),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.6,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: imagePath != null ? Colors.transparent : AppTheme.lightGreen,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: messageContent,
        ),
        const SizedBox(height: 4),
        Text(
          '09:25 AM',
          style: textTheme.bodySmall!.copyWith(
            color: AppTheme.gray,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
