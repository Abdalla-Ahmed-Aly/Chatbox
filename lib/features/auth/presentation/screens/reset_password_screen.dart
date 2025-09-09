import 'package:chatbox/features/auth/presentation/widgets/reset_password/reset_password_form_and_button.dart';
import 'package:chatbox/features/auth/presentation/widgets/reset_password/reset_password_header.dart';
import 'package:flutter/material.dart';


class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            heightFactor: 2,

            child: SingleChildScrollView(
              child: Column(
                children: [
                  const ResetPasswordHeader(),
                  ResetPasswordFormAndButton(email: email,)

                ],



              ),
            ),
          ),
        ),
      ),


    );
  }
}
