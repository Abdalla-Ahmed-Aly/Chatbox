import 'package:chatbox/core/di/service_locator.dart';
import 'package:chatbox/features/home/data/models/contact_model.dart';
import 'package:chatbox/features/home/data/models/setting_model.dart';
import 'package:chatbox/features/home/presentation/widgets/contact_info_widget.dart';
import 'package:chatbox/features/home/presentation/widgets/setting_widget.dart';
import 'package:chatbox/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/theme/app_theme.dart';

class SettingTab extends StatelessWidget {
  const SettingTab({super.key});

  @override
  Widget build(BuildContext context) {
    // serviceLocator.get<ProfileCubit>().getUserProfile();
// context.read<ProfileCubit>().getUserProfile();
    return SafeArea(
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
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: ContactInfoWidget(
                        verticalPadding: 20,
                        contact: ContactModel.contact[2],
                        isNeedToLeadingIcon: true,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Divider(
                      color: AppTheme.gray.withValues(alpha: .1),
                      height: 1,
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) =>
                            SettingWidget(setting: SettingModel.setting[index]),
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
    );
  }
}
