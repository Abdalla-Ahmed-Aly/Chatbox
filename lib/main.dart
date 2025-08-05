import 'package:chatbox/OnboardingScreen.dart';
import 'package:chatbox/splashScreen.dart';
import 'package:chatbox/utils/theme/apptheme.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsBinding.instance.deferFirstFrame();

  runApp(ChatBox());

 WidgetsBinding.instance.allowFirstFrame();
}

class ChatBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darktheme,
      routes: {
        Splashscreen.routeName: (_) => Splashscreen(),
        Onboardingscreen.routeName: (_) => Onboardingscreen(),

      },
      initialRoute: Splashscreen.routeName,
    );
  }
}
