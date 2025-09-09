import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/service_locator.dart';
import 'core/route/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/cubit/send_verification_cubit/send_verification_cubit.dart';


class ChatBox extends StatelessWidget {
  const ChatBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>serviceLocator.get<SendVerificationCubit>(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.routes,
        title: "ChatBox",
      ),
    );
  }
}