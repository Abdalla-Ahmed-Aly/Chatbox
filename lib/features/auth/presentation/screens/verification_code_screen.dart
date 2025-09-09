import 'package:chatbox/features/auth/presentation/widgets/verification/verification_header.dart';
import 'package:flutter/material.dart';
import '../widgets/verification/verification_form_and_button.dart';

class VerificationCodeScreen extends StatelessWidget {
  const VerificationCodeScreen({super.key, required this.email});
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
                  const VerificationHeader(),
                   VerificationFormAndButton(email: email,),




                ],



              ),
            ),
          ),
        ),
      ),


    );
  }
}
