import 'package:chatbox/core/di/service_locator.dart';
import 'package:chatbox/core/route/route_center.dart';
import 'package:chatbox/features/auth/data/storage/token_storage.dart';
import 'package:chatbox/features/home/data/models/setting_model.dart';
import 'package:chatbox/features/home/presentation/widgets/setting_widget.dart';
import 'package:chatbox/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:chatbox/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/theme/app_theme.dart';
import '../../../friend/presentation/widgets/contact_info_widget.dart';

class SettingTab extends StatefulWidget {
  const SettingTab({super.key});

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  TextEditingController biController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  String? serverImageUrl;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // serviceLocator.get<ProfileCubit>()..getUserProfile();
    // final profileCubit = serviceLocator<ProfileCubit>();
    // final state = profileCubit.state;

    // if (state is ProfileSuccess) {
    //   serverImageUrl = state.message.profilePicture.secureUrl;
    //   nameController.text = state.message.username;
    //   biController.text = state.message.bio;
    // }
    return Scaffold(
      backgroundColor: AppTheme.black,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: IconButton(
          icon: Icon(Icons.logout_outlined, color: Colors.white, size: 30),
          onPressed: () async {
            await TokenStorage().clearAll();
            context.push(RouteCenter.onboarding);
          },
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Center(
                child: Text(
                  'Settings',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 10,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Column(
                    children: [
                      BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          if (state is ProfileLoading) {
                            return Center(child: CircularProgressIndicator());
                          } else if (state is ProfileSuccess) {
                            final profile = state.message;

                            return Padding(
                              padding: const EdgeInsets.only(right: 24),
                              child: ContactInfoWidget(
                                image: profile.profilePicture.secureUrl,
                                verticalPadding: 20,
                                bio: profile.bio,
                                username: profile.username,
                                isNeedToLeading: true,
                              ),
                            );
                          }
                          return Center(
                            child: Text(
                              "No data",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: AppTheme.black),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      Divider(
                        color: AppTheme.gray.withValues(alpha: .1),
                        height: 1,
                      ),
                      const SizedBox(height: 24),
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => SettingWidget(
                            setting: SettingModel.setting[index],
                          ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                          itemCount: SettingModel.setting.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
