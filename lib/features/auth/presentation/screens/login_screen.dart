import 'package:chatbox/core/route/route_center.dart';
import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/core/widget/custom_text_button.dart';
import 'package:chatbox/core/widget/custom_button_icon.dart';
import 'package:chatbox/core/widget/custom_button.dart';
import 'package:chatbox/core/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});


  @override
  Widget build(BuildContext context) {
    TextTheme textStyle = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            heightFactor: 1.6,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Log in to Chatbox",
                    style: textStyle.headlineSmall!.copyWith(
                      color: AppTheme.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Welcome back! Sign in using your social account or email to continue us",
                    style: textStyle.bodyLarge!.copyWith(color: AppTheme.gray),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CustomButtonIcon(
                          assetName: "facebook_Icon",
                          onTap: () {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CustomButtonIcon(
                          assetName: "google_Icon",
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(color: AppTheme.gray, thickness: 1),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "OR",
                          style: textStyle.bodyLarge!.copyWith(
                            color: AppTheme.gray,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(color: AppTheme.gray, thickness: 1),
                      ),
                    ],
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
                    isPassword: true,
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.217),
                  CustomButton(
                    onPressed: () {
                      context.pushReplacement(RouteCenter.home);
                    },
                    text: "Log in",
                    buttonColor: AppTheme.lightGreen,
                    textColor: AppTheme.primary,
                  ),
                  const SizedBox(height: 16),
                  CustomTextButton(
                    label: "Don’t have an account? Join us",
                    onTap: () {
                   context.pushReplacement(RouteCenter.register);
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
