import 'package:chatbox/core/route/route_center.dart';
import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/core/utils/app_snack_bars.dart';
import 'package:chatbox/core/utils/validator.dart';
import 'package:chatbox/core/widget/custom_text_button.dart';
import 'package:chatbox/core/widget/custom_button_icon.dart';
import 'package:chatbox/core/widget/custom_button.dart';
import 'package:chatbox/core/widget/custom_text_form_field.dart';
import 'package:chatbox/features/auth/data/model/login_request.dart';
import 'package:chatbox/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:chatbox/features/auth/presentation/cubit/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextTheme textStyle = Theme.of(context).textTheme;
    return Form(
      key: _formKey,
      child: Scaffold(
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
                      style: textStyle.bodyLarge!.copyWith(
                        color: AppTheme.gray,
                      ),
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
                      validator: (value) =>
                          Validator.validateField(value, 'email'),
                      controller: _emailController,
                    ),
                    const SizedBox(height: 30),
                    CustomTextFormField(
                      textInputType: TextInputType.visiblePassword,
                      label: "Password",
                      validator: (value) =>
                          Validator.validateField(value, 'password'),
                      isPassword: true,
                      controller: _passwordController,
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.217),
                    BlocConsumer<LoginCubit, LoginStates>(
                      listener: (context, state) {
                        if (state is LoginSuccess) {
                          context.pushReplacement(RouteCenter.home);
                          AppSnackBars.showSuccessSnackBar(
                            context: context,
                            message: state.message,
                          );
                        } else if (state is LoginFailure) {
                          AppSnackBars.showErrorSnackBar(
                            context: context,
                            message: state.error,
                          );
                        }
                      },
                      builder: (context, state) {
                        return AbsorbPointer(
                          absorbing: state is LoginLoading,
                          child: CustomButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<LoginCubit>().login(
                                  LoginRequest(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                              }
                            },
                            isLoading: state is LoginLoading,
                            text: "Log in",
                            buttonColor: AppTheme.lightGreen,
                            textColor: AppTheme.primary,
                          ),
                        );
                      },
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
      ),
    );
  }
  dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
