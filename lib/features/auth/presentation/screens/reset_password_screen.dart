import 'package:chatbox/core/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../home/presentation/screens/homescreen.dart';
class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});
static const String routeName = '/reset-password';
  @override
  Widget build(BuildContext context) {
    TextTheme textStyle = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            heightFactor: 2,

            child: SingleChildScrollView(
              child: Column(
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
                  CustomTextFormField(textInputType: TextInputType.visiblePassword, label: "New Password"),
                  const SizedBox(height: 30),
                  CustomTextFormField(textInputType: TextInputType.visiblePassword, label: "Re-enter Password"),
                  const SizedBox(height: 30),
                  CustomButton(onPressed: (){
                    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                  }, text: "Update Password",textColor: AppTheme.primary,buttonColor: AppTheme.green,)


                ],



              ),
            ),
          ),
        ),
      ),


    );
  }
}
