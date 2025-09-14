import 'package:chatbox/core/di/service_locator.dart';
import 'package:chatbox/core/route/route_center.dart';
import 'package:chatbox/features/auth/presentation/cubit/confirm_otp_cubit/confirm_otp_cubit.dart';
import 'package:chatbox/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:chatbox/features/auth/presentation/cubit/register_cubit/register_cubit.dart';
import 'package:chatbox/features/auth/presentation/cubit/reset_password_cubit/reset_password_cubit.dart';
import 'package:chatbox/features/auth/presentation/screens/login_screen.dart';
import 'package:chatbox/features/chat/presentation/screens/chat_screen.dart';
import 'package:chatbox/features/createGroup/presentation/screens/Create_GroupScreen.dart';
import 'package:chatbox/features/home/presentation/screens/homescreen.dart';
import 'package:chatbox/features/splash/presentation/screens/onboarding_screen.dart';
import 'package:chatbox/features/splash/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/reset_password_screen.dart';
import '../../features/auth/presentation/screens/verification_code_screen.dart';
import '../../features/callForChat/presentation/screens/call_screen.dart';
import '../../features/callForChat/presentation/screens/ring_screen.dart';
import '../../features/home/presentation/widgets/qr_code_screen.dart';
import '../../features/updateProfile/presentation/screens/update_Profile_Screen.dart';

class AppRouter {
  static final routes = GoRouter(
    routes: [
      GoRoute(
        path: RouteCenter.splash,
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: RouteCenter.onboarding,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const OnboardingScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          );
        },
      ),
      GoRoute(
        path: RouteCenter.login,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: BlocProvider(
              create: (context) => serviceLocator.get<LoginCubit>(),
              child: const LoginScreen(),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          );
        },
      ),
      GoRoute(
        path: RouteCenter.register,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: BlocProvider(
              create: (context) => serviceLocator.get<RegisterCubit>(),
              child: const RegisterScreen(),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          );
        },
      ),
      GoRoute(
        path: RouteCenter.home,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const HomeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          );
        },
      ),
      GoRoute(
        path: RouteCenter.chatScreen,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const ChatScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          );
        },
      ),
      GoRoute(
        path: RouteCenter.verification,
        pageBuilder: (context, state) {
          final String email = state.extra as String;
          return CustomTransitionPage(
            child: BlocProvider(
              create: (context) => serviceLocator.get<ConfirmOtpCubit>(),
              child: VerificationCodeScreen(email: email),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          );
        },
      ),
      GoRoute(
        path: RouteCenter.resetPassword,
        pageBuilder: (context, state) {
          final String email = state.extra as String;
          return CustomTransitionPage(
            child: BlocProvider(
              create: (context) => serviceLocator.get<ResetPasswordCubit>(),
              child: ResetPasswordScreen(email: email),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          );
        },
      ),
      GoRoute(
        path: RouteCenter.qrCode,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const QrCodeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          );
        },
      ),
      GoRoute(
        path: RouteCenter.createGroup,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const CreateGroupscreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          );
        },
      ),
      GoRoute(
        path: RouteCenter.callScreen,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const CallScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          );
        },
      ),
      GoRoute(
        path: RouteCenter.ringScreen,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const RingScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          );
        },
      ),
      GoRoute(
        path: RouteCenter.updateProfile,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const UpdateProfileScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          );
        },
      ),
    ],
  );
}
