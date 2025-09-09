import 'package:flutter/material.dart';

import '../../../../../core/widget/custom_text_button.dart';
import '../../screens/forgot_password_screen.dart';

class ForgetButton extends StatelessWidget {
  const ForgetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextButton(
      label: "Forgot password?",
      onTap: () {
        showModalBottomSheet(
          context: context,
          constraints: BoxConstraints(maxWidth: double.infinity),
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          builder: (context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ForgotPasswordScreen(),
          ),
        );
      },
    );
  }
}
