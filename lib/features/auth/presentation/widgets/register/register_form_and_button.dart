import 'package:chatbox/core/utils/app_snack_bars.dart';
import 'package:chatbox/features/auth/data/model/register_request.dart';
import 'package:chatbox/features/auth/presentation/widgets/register/forget_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/route/route_center.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/validator.dart';
import '../../../../../core/widget/custom_button.dart';
import '../../../../../core/widget/custom_text_form_field.dart';
import '../../cubit/register_cubit/register_cubit.dart';
import '../../cubit/register_cubit/register_state.dart';


class RegisterFormAndButton extends StatefulWidget {
   const RegisterFormAndButton({super.key});

  @override
  State<RegisterFormAndButton> createState() => _RegisterFormAndButtonState();
}

class _RegisterFormAndButtonState extends State<RegisterFormAndButton> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _userNameController=TextEditingController();

   final TextEditingController _passwordController=TextEditingController();

   final TextEditingController _phoneNumberController=TextEditingController();

   final TextEditingController _emailController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Form(
      key:_formKey ,
      child: Column(
        children: [
          CustomTextFormField(
            textInputType: TextInputType.name,
            label: "Username",
            controller:_userNameController,
             validator: (value) =>
                 Validator.validateField(value, 'name'),
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            textInputType: TextInputType.phone,
            label: "Your phone number",
            controller: _phoneNumberController,
            validator: (value) =>
                Validator.validateField(value, 'phone'),
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            textInputType: TextInputType.emailAddress,
            label: "Your email",
            controller:_emailController ,
            validator: (value) =>
                Validator.validateField(value, 'email'),
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            textInputType: TextInputType.visiblePassword,
            label: "Password",
            controller: _passwordController,
            isPassword: true,
            validator: (value) =>
                Validator.validateField(value, 'password'),
          ),
          const SizedBox(height: 30),
          const ForgetButton(),
          SizedBox(height: MediaQuery
              .sizeOf(context)
              .height * 0.06),
          BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if(state is RegisterSuccess){
                context.pushReplacement(RouteCenter.login);
             AppSnackBars.showSuccessSnackBar(context: context, message: state.message);
              }else if(state is RegisterFailure){
              AppSnackBars.showErrorSnackBar(context: context, message: state.error);
              }

            },
            builder: (context, state) {
              return AbsorbPointer(
                absorbing: state is RegisterLoading,
                child: CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {

                    }
                      context.read<RegisterCubit>().register(RegisterRequest(
                          password: _passwordController.text,
                          phoneNumber: _phoneNumberController.text,
                          email: _emailController.text,
                          username: _userNameController.text));

                  },
                  isLoading: state is RegisterLoading,
                  text: "Create an account",
                  buttonColor: AppTheme.lightGreen,
                  textColor: AppTheme.primary,
                ),
              );
            },
          ),
          const SizedBox(height: 16),

        ],
      ),
    );
  }

   @override
  void dispose() {
     _passwordController.dispose();
     _emailController.dispose();
     _phoneNumberController.dispose();
     _userNameController.dispose();
     super.dispose();
   }
}
