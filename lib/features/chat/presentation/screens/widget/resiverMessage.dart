import 'package:chatbox/core/widget/OnlineAvatar.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';

class ResiverMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OnlineAvatar(
          imagePath: 'assets/images/model1.png',
          isOnline: false,
          radius: 20,
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Column(
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
                      child: Text(
                        'Hello! Nazrul, saaaaaaaaaaSQ                                                                         ضسسسسسسسسسسسسسسسسسسسسسسسسسسسسسسسسسaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaahow are you?',
                        style: textTheme.bodyMedium!.copyWith(
                          color: AppTheme.black.withOpacity(0.8),
                        ),
                      ),
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
          ),
        ),
      ],
    );
  }
}
