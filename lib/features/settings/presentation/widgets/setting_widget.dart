import 'package:chatbox/core/route/route_center.dart';
import 'package:chatbox/features/settings/data/models/setting_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';

class SettingWidget extends StatelessWidget {
  const SettingWidget({super.key, required this.setting});
  final SettingModel setting;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size screenSize = MediaQuery.sizeOf(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: setting.mainTeat == "Account"
            ? () {
                context.push(RouteCenter.updateProfile);
              }
            : () {},
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              SizedBox(width: 24),
              SvgPicture.asset(
                setting.iconPath,
                width: screenSize.width * 0.06,
                height: screenSize.height * 0.054,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  setting.subText == null
                      ? const SizedBox(height: 20)
                      : const SizedBox(),
                  Text(
                    setting.mainTeat,
                    style: textTheme.titleLarge!.copyWith(
                      color: AppTheme.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    setting.subText ?? "",
                    style: textTheme.bodySmall!.copyWith(
                      color: AppTheme.gray,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
