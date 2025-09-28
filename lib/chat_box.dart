import 'package:chatbox/features/home/presentation/cubit/upload_story/upload_story_cubit.dart';
import 'package:chatbox/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/service_locator.dart';
import 'core/route/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/cubit/send_verification_cubit/send_verification_cubit.dart';
import 'features/friend/presentation/cubit/friend_cubit/friend_cubit.dart';

class ChatBox extends StatelessWidget {
  const ChatBox({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator.get<SendVerificationCubit>(),
        ),
        BlocProvider(create: (_) => serviceLocator.get<ProfileCubit>()),
        BlocProvider(create: (context) => serviceLocator.get<FriendCubit>()),
        BlocProvider(
          create: (context) => serviceLocator.get<UploadStoryCubit>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.routes,
        title: "ChatBox",
      ),
    );
  }
}
