import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/core/widget/custom_button.dart';
import 'package:chatbox/core/widget/custom_text_form_field.dart';
import 'package:chatbox/feature/auth/presentation/screens/forgot_password_screen.dart';
import 'package:chatbox/feature/auth/presentation/screens/login_screen.dart';
import 'package:chatbox/feature/auth/presentation/widget/custom_text_button.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  static const String routeName = '/register';

  @override
  Widget build(BuildContext context) {
    TextTheme textStyle = Theme.of(context).textTheme;
    return Scaffold(
      body:
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24 ),
          child: Center(
            heightFactor:1.6 ,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Sign up with Email",style:textStyle.headlineSmall!.copyWith(color: AppTheme.black),),
                  const SizedBox(height: 16,),
                  Text("Get chatting with friends and family today by signing up for our chat app!",style:textStyle.bodyLarge!.copyWith(color: AppTheme.gray),),
                  const SizedBox(height: 30,),
                  CustomTextFormField(textInputType: TextInputType.name, hintText: "Your name"),
                  const SizedBox(height: 30,),
                  CustomTextFormField(textInputType: TextInputType.emailAddress, hintText: "Your email"),
                  const SizedBox(height: 30,),
                  CustomTextFormField(textInputType: TextInputType.visiblePassword, hintText: "Password"),
                  const SizedBox(height: 30,),
                  CustomTextFormField(textInputType: TextInputType.visiblePassword, hintText: "Confirm Password"),
                  const SizedBox(height:30,),
                  CustomTextButton(label: "Forgot password?",onTap: (){
                    showModalBottomSheet(context: context,constraints: BoxConstraints(maxWidth: double.infinity) ,isScrollControlled: true,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),builder: (context) => Padding(
                      padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom,),
                      child: ForgotPasswordScreen(),
                    ),);

                  },),
                  SizedBox(height:MediaQuery.sizeOf(context).height *0.217,),
                  CustomButton(onPressed: (){}, text: "Create an account",buttonColor: AppTheme.green,textColor: AppTheme.primary,),
                  const SizedBox(height: 16,),
                  CustomTextButton(label: "Have an account? Log in", onTap: (){
                    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                  })




                ],



              ),
            ),
          ),
        ),
      )
      ,

    );
  }
}