import 'package:chatbox/feature/auth/presentation/screens/login_screen.dart';
import 'package:chatbox/feature/splash/presentation/screens/onboarding_screen.dart';
import 'package:chatbox/feature/splash/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'feature/auth/presentation/screens/register_screen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsBinding.instance.deferFirstFrame();

  runApp(ChatBox());

 WidgetsBinding.instance.allowFirstFrame();
}

class ChatBox extends StatelessWidget {
  const ChatBox({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        OnboardingScreen.routeName: (_) => OnboardingScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
      },
      initialRoute: SplashScreen.routeName,
    );
  }
}
