import 'dart:ui';

import 'package:chatbox/utils/coustome_widget/CustomrButton_Icons.dart';
import 'package:chatbox/utils/coustome_widget/customeButton.dart';
import 'package:chatbox/utils/theme/apptheme.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;


class Onboardingscreen extends StatelessWidget {
  static const String routeName = '/onboarding';

  @override
  Widget build(BuildContext context) {
    final textTheam = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.black,

      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              left: -200,
              top: 50,
              right: -100,
              child: Transform.rotate(
                angle: 134.23 * math.pi / 180,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(300),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 100, sigmaY: 50),
                    child: Container(
                      width: 300.31,
                      height: 400.52,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF0A1832).withOpacity(0.5),
                            const Color(0xFF43116A).withOpacity(0.9),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(300),
                      ),
                    ),
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
                        style: textTheam.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                        ),
                      ),
                    ],
                  ),

                  Text(
                    'Connect friends easily & quickly',
                    style: textTheam.displayLarge,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Our chat app is the perfect way to stay connected with friends and family.',
                    style: textTheam.titleLarge?.copyWith(
                      color: Color(0xffB9C1BE),
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 39),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomrbuttonIcons(
                        onTap: _onGoogleTap,
                        assetName: 'google_Icon',
                      ),
                      SizedBox(width: 21),
                      CustomrbuttonIcons(
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
                        child: Text('OR', style: textTheam.headlineSmall),
                      ),
                      Expanded(
                        child: Divider(color: AppTheme.gray, thickness: 1),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Customebutton(
                    onPressed: () {},
                    text: 'Sign up withn mails',
                    textColor: AppTheme.black,
                    buttonColor: AppTheme.whitegreen,
                  ),
                  SizedBox(height: 40),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Existing account? Log in',
                      style: textTheam.titleLarge,
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
