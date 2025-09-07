import 'package:chatbox/core/route/route_center.dart';
import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/core/widget/custom_text_button.dart';
import 'package:chatbox/core/widget/custom_button.dart';
import 'package:chatbox/core/widget/custom_text_form_field.dart';
import 'package:chatbox/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});


  @override
  Widget build(BuildContext context) {
    TextTheme textStyle = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(

            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  CustomTextFormField(
                    textInputType: TextInputType.name,
                    label: "Your name",
                  ),
                  const SizedBox(height: 30),
                  CustomTextFormField(
                    textInputType: TextInputType.phone,
                    label: "Your phone number",
                  ),
                  const SizedBox(height: 30),
                  CustomTextFormField(
                    textInputType: TextInputType.emailAddress,
                    label: "Your email",
                  ),
                  const SizedBox(height: 30),
                  CustomTextFormField(
                    textInputType: TextInputType.visiblePassword,
                    label: "Password",
                  ),
                  const SizedBox(height: 30),
                  CustomTextFormField(
                    textInputType: TextInputType.visiblePassword,
                    label: "Confirm Password",
                  ),
                  const SizedBox(height: 30),
                  CustomTextButton(
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
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.06),
                  CustomButton(
                    onPressed: () {
                     context.push(RouteCenter.home);
                    },
                    text: "Create an account",
                    buttonColor: AppTheme.lightGreen,
                    textColor: AppTheme.primary,
                  ),
                  const SizedBox(height: 16),
                  CustomTextButton(
                    label: "Have an account? Log in",
                    onTap: () {
                      context.pushReplacement(RouteCenter.login);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
