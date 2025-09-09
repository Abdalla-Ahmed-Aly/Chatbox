import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/route/route_center.dart';
import '../../../../../core/widget/custom_text_button.dart';

class HaveAnAccount extends StatelessWidget {
  const HaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextButton(
      label: "Have an account? Log in",
      onTap: () {
        context.pushReplacement(RouteCenter.login);
      },
    );
  }
}
