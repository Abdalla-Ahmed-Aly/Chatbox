import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';
class ForgetHeader extends StatelessWidget {
  const ForgetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text("Forgot password",style: textTheme.headlineMedium!.copyWith(color: AppTheme.black),),
        const SizedBox(height: 9),
        Text("Enter your email for the verification proccesss,we will send 6 digits code to your email.",style: textTheme.bodyLarge!.copyWith(color: AppTheme.gray),),
        const SizedBox(height: 36),

      ],

    );
  }
}
