import 'package:chatbox/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widget/custom_button_Icon.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../auth/presentation/screens/register_screen.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = '/onboarding';

  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.black,

      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              left: 80,
              top: -130,
              child: Opacity(
                opacity: 0.4,
                child: Container(
                  width: 380,
                  height: 600,
                  transform: Matrix4.identity()..rotateZ(math.pi / 10),
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.64, 0.50),
                      end: Alignment(-0.07, 0.35),
                      colors: const [Color(0xFF42106A), Color(0xFF0A1731)],
                    ),
                    shape: const OvalBorder(),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 35, right: 16, left: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/cWhite.png',
                        height: 19,
                        width: 16,
                        color: Colors.white,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'ChatBox',
                        style: textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                        ),
                      ),
                    ],
                  ),

                  Text(
                    'Connect friends easily & quickly',
                    style: textTheme.displayLarge,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Our chat app is the perfect way to stay connected with friends and family.',
                    style: textTheme.titleLarge?.copyWith(
                      color: Color(0xffB9C1BE),
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 39),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButtonIcon(
                        onTap: _onGoogleTap,
                        assetName: 'google_Icon',
                      ),
                      SizedBox(width: 21),
                      CustomButtonIcon(
                        onTap: _onFacebookTap,
                        assetName: 'facebook_Icon',
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(color: AppTheme.gray, thickness: 1),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 19),
                        child: Text('OR', style: textTheme.headlineSmall),
                      ),
                      Expanded(
                        child: Divider(color: AppTheme.gray, thickness: 1),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  CustomButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        RegisterScreen.routeName,
                      );
                    },
                    text: 'Sign up withn mails',
                    textColor: AppTheme.black,
                    buttonColor: AppTheme.whiteGreen,
                  ),
                  SizedBox(height: 40),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        LoginScreen.routeName,
                      );
                    },
                    child: Text(
                      'Existing account? Log in',
                      style: textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onGoogleTap() {}
  void _onFacebookTap() {}
}
