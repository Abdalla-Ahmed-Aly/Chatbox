import 'package:chatbox/features/auth/presentation/screens/login_screen.dart';
import 'package:chatbox/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:chatbox/features/auth/presentation/screens/verification_code_screen.dart';
import 'package:chatbox/features/callForChat/presentation/screens/call_screen.dart';
import 'package:chatbox/features/chat/presentation/screens/chatScreen.dart';
import 'package:chatbox/features/createGroup/presentation/screens/Create_GroupScreen.dart';
import 'package:chatbox/features/splash/presentation/screens/onboarding_screen.dart';
import 'package:chatbox/features/splash/presentation/screens/splash_screen.dart';
import 'package:chatbox/features/updateProfile/presentation/screens/update_Profile_Screen.dart';
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/screens/register_screen.dart';
import 'features/callForChat/presentation/screens/ring_screen.dart';
import 'features/home/presentation/screens/homescreen.dart';
import 'features/home/presentation/widgets/qr_code_screen.dart';

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
      theme: AppTheme.lightTheme,
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        OnboardingScreen.routeName: (_) => OnboardingScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        ChatScreen.routeName: (_) => ChatScreen(),
        VerificationCodeScreen.routeName: (_) => VerificationCodeScreen(),
        ResetPasswordScreen.routeName: (_) => ResetPasswordScreen(),
        QrCodeScreen.routeName: (_) => QrCodeScreen(),
        CreateGroupscreen.routeName: (_) => CreateGroupscreen(),
        CallScreen.routeName: (_) => CallScreen(),
         RingScreen.routeName: (_) => RingScreen(),
         UpdateProfileScreen.routeName: (_) => UpdateProfileScreen(),
      },
      initialRoute:  SplashScreen.routeName,
    );
  }
}
