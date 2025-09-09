import 'package:chatbox/core/utils/app_snack_bars.dart';
import 'package:chatbox/features/auth/data/model/reset_password_request.dart';
import 'package:chatbox/features/auth/presentation/cubit/reset_password_cubit/reset_password_cubit.dart';
import 'package:chatbox/features/auth/presentation/cubit/reset_password_cubit/reset_password_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/route/route_center.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/validator.dart';
import '../../../../../core/widget/custom_button.dart';
import '../../../../../core/widget/custom_text_form_field.dart';

class ResetPasswordFormAndButton extends StatefulWidget {
  const ResetPasswordFormAndButton({super.key,required this.email});
  final String email;

  @override
  State<ResetPasswordFormAndButton> createState() => _ResetPasswordFormAndButtonState();
}

class _ResetPasswordFormAndButtonState extends State<ResetPasswordFormAndButton> {
  final TextEditingController _password=TextEditingController();
  final TextEditingController _confirmPassword=TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(textInputType: TextInputType.visiblePassword, label: "New Password",controller: _password,validator: (value) =>
              Validator.validateField(value, 'password'),),
          const SizedBox(height: 30),
          CustomTextFormField(textInputType: TextInputType.visiblePassword, label: "Re-enter Password",controller: _confirmPassword,),
          const SizedBox(height: 30),
          BlocConsumer<ResetPasswordCubit, ResetPasswordStates>(
        listener: (context, state) {
        if (state is ResetPasswordSuccess){
      AppSnackBars.showSuccessSnackBar(context: context, message: state.message);
      context.pushReplacement(RouteCenter.home);
        }
        if(state is ResetPasswordFailure){
      AppSnackBars.showErrorSnackBar(context: context, message: state.error);
        }
        },
        builder: (context, state) {
      return AbsorbPointer(
        absorbing: state is ResetPasswordLoading,
        child: CustomButton(onPressed: (){
        if (_formKey.currentState!.validate()) {
          context.read<ResetPasswordCubit>().resetPassword(ResetPasswordRequest(newPassword: _password.text, confirmPassword: _confirmPassword.text, email: widget.email));

        }

            },
          isLoading: state is ResetPasswordLoading,
          text: "Update Password",textColor: AppTheme.primary,buttonColor: AppTheme.green,),
      );
        },
      )



        ],
      ),
    );
  }
  @override
  void dispose() {
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }
}
