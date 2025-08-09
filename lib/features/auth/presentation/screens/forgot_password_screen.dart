import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../../core/widget/custom_text_form_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 30,start: 20, end: 20, bottom: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Forgot password",style: textTheme.headlineMedium!.copyWith(color: AppTheme.black),),
            const SizedBox(height: 9),
            Text("Enter your email for the verification proccesss,we will send 6 digits code to your email.",style: textTheme.bodyLarge!.copyWith(color: AppTheme.gray),),
            const SizedBox(height: 36),
            CustomTextFormField(textInputType: TextInputType.emailAddress, label: "Email"),
            const SizedBox(height: 30),
            CustomButton(text: "Continue",onPressed: (){},buttonColor: AppTheme.green,textColor: AppTheme.primary,)




          ],



        ),
      ),
    );
  }
}
