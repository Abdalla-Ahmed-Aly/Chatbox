import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textStyle = Theme.of(context).textTheme;
    return  Column(
      children: [
        Text(
          "Sign up with Email",
          style: textStyle.headlineSmall!.copyWith(
            color: AppTheme.black,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Get chatting with friends and family today by signing up for our chat app!",
          style: textStyle.bodyLarge!.copyWith(color: AppTheme.gray),
        ),
        const SizedBox(height: 30),

      ],
    );
  }
}
