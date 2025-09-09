import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';
class VerificationHeader extends StatelessWidget {
  const VerificationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textStyle=Theme.of(context).textTheme;
    return Column(
      children: [
        Image.asset("assets/images/textMessage.png",height: MediaQuery.sizeOf(context).height*0.15,width:double.infinity,),
        const SizedBox(height: 30),
        Text(
          "Enter 6 Digits Code",
          style: textStyle.headlineSmall!.copyWith(
            color: AppTheme.black,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Enter the 6 digits code that you received on your email",
          style: textStyle.bodyLarge!.copyWith(color: AppTheme.gray),
        ),
        const SizedBox(height: 30),

      ],

    );
  }
}
