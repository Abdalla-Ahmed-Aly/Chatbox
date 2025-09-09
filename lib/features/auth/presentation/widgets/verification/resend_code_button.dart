import 'package:chatbox/core/utils/app_snack_bars.dart';
import 'package:chatbox/features/auth/data/model/send_verification_request.dart';
import 'package:chatbox/features/auth/presentation/cubit/send_verification_cubit/send_verification_cubit.dart';
import 'package:chatbox/features/auth/presentation/cubit/send_verification_cubit/send_verification_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resend_timer_button/resend_timer_button.dart';
import '../../../../../core/theme/app_theme.dart';


class ResendCodeButton extends StatelessWidget {
  const ResendCodeButton({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    TextTheme textStyle = Theme
        .of(context)
        .textTheme;
    return BlocConsumer<SendVerificationCubit, SendVerificationStates>(
      listener: (context, state) {
      if(state is SendVerificationFailure){
        AppSnackBars.showErrorSnackBar(context: context, message: state.error);
      }if(state is SendVerificationSuccess){
        AppSnackBars.showSuccessSnackBar(context: context, message: state.message);
      }
      },
      builder: (context, state) {
        return ResendTimerButton(onPressed: () {
          context.read<SendVerificationCubit>().sendVerification(
              SendVerificationRequest(email: email));
        },
          text: Text("Resend Code",
            style: textStyle.titleMedium!.copyWith(color: AppTheme.black),),
          duration: 30,
          buttonType: ButtonType.text_button,);
      },
    );
  }
}
