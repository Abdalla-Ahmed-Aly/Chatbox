import 'package:chatbox/features/auth/presentation/widgets/forget/forget_form_and_button.dart';
import 'package:chatbox/features/auth/presentation/widgets/forget/forget_header.dart';
import 'package:flutter/material.dart';



class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
          top: 30, start: 20, end: 20, bottom: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ForgetHeader(),
            const ForgetFormAndButton()


          ],


        ),
      ),
    )
    ;
  }
}
