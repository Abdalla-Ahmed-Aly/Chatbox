import 'package:chatbox/features/auth/presentation/widgets/register/have_an_account.dart';
import 'package:chatbox/features/auth/presentation/widgets/register/register_form_and_button.dart';
import 'package:chatbox/features/auth/presentation/widgets/register/register_header.dart';
import 'package:flutter/material.dart';



class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const RegisterHeader(),
                  const RegisterFormAndButton(),
                  const HaveAnAccount(),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
