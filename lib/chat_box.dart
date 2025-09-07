import 'package:flutter/material.dart';
import 'core/route/app_router.dart';
import 'core/theme/app_theme.dart';
class ChatBox extends StatelessWidget {
  const ChatBox({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.routes,
      title: "ChatBox",
    );
  }
}