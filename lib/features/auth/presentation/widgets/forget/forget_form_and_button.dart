import 'package:chatbox/core/utils/app_snack_bars.dart';
import 'package:chatbox/features/auth/data/model/send_verification_request.dart';
import 'package:chatbox/features/auth/presentation/cubit/send_verification_cubit/send_verification_cubit.dart';
import 'package:chatbox/features/auth/presentation/cubit/send_verification_cubit/send_verification_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/route/route_center.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/validator.dart';
import '../../../../../core/widget/custom_button.dart';
import '../../../../../core/widget/custom_text_form_field.dart';

class ForgetFormAndButton extends StatefulWidget {
  const ForgetFormAndButton({super.key});

  @override
  State<ForgetFormAndButton> createState() => _ForgetFormAndButtonState();
}

class _ForgetFormAndButtonState extends State<ForgetFormAndButton> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key:_formKey ,
          child: CustomTextFormField(
              textInputType: TextInputType.emailAddress, label: "Email",controller: _emailController,validator: (value) =>
              Validator.validateField(value, 'email'),),
        ),
        const SizedBox(height: 30),
        BlocConsumer<SendVerificationCubit, SendVerificationStates>(
          listener: (context, state) {
            if(state is SendVerificationSuccess){
              AppSnackBars.showSuccessSnackBar(context: context, message: state.message);
              context.pushReplacement(RouteCenter.verification);
              context.pop();
            }else if (state is SendVerificationFailure){
              AppSnackBars.showErrorSnackBar(context: context, message: state.error);
            }
          },
          builder: (context, state) {
            return AbsorbPointer(
              absorbing: state is SendVerificationLoading,
              child: CustomButton(text: "Continue", onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<SendVerificationCubit>().sendVerification(SendVerificationRequest(email: _emailController.text));
                }


              }, buttonColor: AppTheme.green, textColor: AppTheme.primary,isLoading: state is SendVerificationLoading,),
            );
          },
        )


      ],

    );
  }
}
