import 'package:chatbox/core/utils/app_snack_bars.dart';
import 'package:chatbox/core/widget/loading_indicator.dart';
import 'package:chatbox/features/auth/data/model/otp_request.dart';
import 'package:chatbox/features/auth/presentation/cubit/confirm_otp_cubit/confirm_otp_cubit.dart';
import 'package:chatbox/features/auth/presentation/cubit/confirm_otp_cubit/confirm_otp_states.dart';
import 'package:chatbox/features/auth/presentation/widgets/verification/resend_code_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import '../../../../../core/route/route_center.dart';
import '../../../../../core/theme/app_theme.dart';



class VerificationFormAndButton extends StatefulWidget {
  const VerificationFormAndButton({super.key,required this.email});
  final String email;

  @override
  State<VerificationFormAndButton> createState() => _VerificationFormAndButtonState();
}

class _VerificationFormAndButtonState extends State<VerificationFormAndButton> {
  final TextEditingController _otp=TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextTheme textStyle=Theme.of(context).textTheme;
    return BlocConsumer<ConfirmOtpCubit, ConfirmOtpStates>(
  listener: (context, state) {
    if(state is ConfirmOtpSuccessState){
      AppSnackBars.showSuccessSnackBar(context: context, message:state.message);
      context.pushReplacement(RouteCenter.resetPassword,extra: widget.email);
    }else if(state is ConfirmOtpErrorState){
      AppSnackBars.showErrorSnackBar(context: context, message:state.error);
    }
  },
  builder: (context, state) {
    if (state is ConfirmOtpLoadingState) {
      return const LoadingIndicator();
    } else {
      return Column(
      children: [
        Pinput(
          onCompleted: (value) {
          context.read<ConfirmOtpCubit>().confirmOtp(OtpRequest(email: widget.email, code:_otp.text));
          _otp.clear();
          },
          keyboardType: TextInputType.number,
          controller: _otp,
          length: 6,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          defaultPinTheme: PinTheme(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
              textStyle: textStyle.labelMedium,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppTheme.primary,
                  border: Border.all(color: AppTheme.gray, width: 2)

              )

          ),
          disabledPinTheme: PinTheme(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
              textStyle: textStyle.labelMedium,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppTheme.primary,
                  border: Border.all(color: AppTheme.gray, width: 2)

              )

          ),
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          errorPinTheme: PinTheme(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
              textStyle: textStyle.labelMedium,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppTheme.primary,
                  border: Border.all(color: AppTheme.red, width: 2)

              )

          ),


        ),
        const SizedBox(height: 30),
        ResendCodeButton(email: widget.email,)



      ],


            );
    }
  },
);
  }
  @override
  void dispose() {
   _otp.dispose();
    super.dispose();
  }
}
