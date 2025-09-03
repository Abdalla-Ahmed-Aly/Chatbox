import 'dart:io';
import 'package:chatbox/features/chat/presentation/screens/widget/resiver/continerCusomeResiver.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_theme.dart';
import 'playRecordResiver.dart';

class ResiverMessage extends StatelessWidget {
  final String? audioPath;
  final String? imagePath;
  final String? text;

  const ResiverMessage({super.key, this.audioPath, this.imagePath, this.text});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    Widget messageContent;

    if (audioPath != null) {
      messageContent = Playrecordresiver(audioPath: audioPath!);
    } else if (imagePath != null) {
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
            width: 120,
            height: 150,
          ),
        ),
      );
    } else {
      messageContent = Text(
        text ?? 'Hello! Nazrul, كيف حالك اليوم؟',
        style: textTheme.bodyMedium!.copyWith(
          color: AppTheme.black.withOpacity(0.8),
        ),
      );
    }

    return Continercusomeresiver(
      imagePath: 'assets/images/model1.png',
      isOnline: false,
      messageContent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ahmed',
            style: textTheme.bodyLarge!.copyWith(
              color: AppTheme.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 50, bottom: 10),
                child: messageContent,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Text(
                  '09:25 AM',
                  style: textTheme.bodySmall!.copyWith(
                    color: AppTheme.gray,
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
