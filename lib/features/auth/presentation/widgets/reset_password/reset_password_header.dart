
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';

class ResetPasswordHeader extends StatelessWidget {
  const ResetPasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textStyle = Theme.of(context).textTheme;
    return Column(
      children: [
        Image.asset("assets/images/resetPassword.png",height: MediaQuery.sizeOf(context).height*0.15,width:double.infinity,),
        const SizedBox(height: 30),
        Text(
          "Reset Password",
          style: textStyle.headlineSmall!.copyWith(
            color: AppTheme.black,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Set the new password for your account so you can login and access all the features.",
          style: textStyle.bodyLarge!.copyWith(color: AppTheme.gray),
        ),
        const SizedBox(height: 30),

      ],
    );
  }
}
