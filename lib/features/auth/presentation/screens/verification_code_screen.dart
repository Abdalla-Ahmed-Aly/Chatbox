import 'package:chatbox/core/route/route_center.dart';
import 'package:chatbox/core/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:resend_timer_button/resend_timer_button.dart' show ResendTimerButton, ButtonType;


import '../../../../core/theme/app_theme.dart';

class VerificationCodeScreen extends StatelessWidget {
  const VerificationCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textStyle=Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            heightFactor: 2,

            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset("assets/images/textMessage.png",height: MediaQuery.sizeOf(context).height*0.15,width:double.infinity,),
                  const SizedBox(height: 30),
                  Text(
                    "Enter 6 Digits Code",
                    style: textStyle.headlineSmall!.copyWith(
                      color: AppTheme.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Enter the 6 digits code that you received on your email",
                    style: textStyle.bodyLarge!.copyWith(color: AppTheme.gray),
                  ),
                  const SizedBox(height: 30),
                  Pinput(
                    onCompleted: (value) {
                      context.pushReplacement(RouteCenter.resetPassword);

                    },
                    keyboardType: TextInputType.number,
                    length: 6,
                   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    //closeKeyboardWhenCompleted: true,
                    defaultPinTheme: PinTheme(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 9),
                      textStyle: textStyle.labelMedium,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppTheme.primary,
                        border: Border.all(color: AppTheme.gray,width: 2)

                      )

                    ),
                    disabledPinTheme: PinTheme(
                      width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 9),
                        textStyle: textStyle.labelMedium,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppTheme.primary,
                            border: Border.all(color: AppTheme.gray,width: 2)

                        )

                    ),
                    onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                    errorPinTheme: PinTheme(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 9),
                        textStyle: textStyle.labelMedium,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppTheme.primary,
                            border: Border.all(color: AppTheme.red,width: 2)

                        )

                    ),




                  ),
                  const SizedBox(height: 30),
                  ResendTimerButton(onPressed: (){}, text: Text("Resend Code",style: textStyle.titleMedium!.copyWith(color: AppTheme.black),), duration: 5,buttonType:ButtonType.text_button,),
                  const SizedBox(height: 30),
                  CustomButton(onPressed: (){
                    context.pushReplacement(RouteCenter.resetPassword);
                  }, text: "Continue",textColor: AppTheme.primary,buttonColor: AppTheme.green,)


                ],



              ),
            ),
          ),
        ),
      ),


    );
  }
}
