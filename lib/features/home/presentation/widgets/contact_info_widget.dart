import 'dart:io';

import 'package:chatbox/core/route/route_center.dart';
import 'package:chatbox/features/home/data/models/contact_model.dart';
import 'package:chatbox/features/home/data/models/storymodels/user.dart';

import 'package:chatbox/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/theme/app_theme.dart';

class ContactInfoWidget extends StatefulWidget {
  const ContactInfoWidget({
    super.key,
    required this.contact,
    this.isNeedToLeadingIcon = false,
    this.verticalPadding = 0,
  });
  final ContactModel contact;
  final bool isNeedToLeadingIcon;
  final double verticalPadding;

  @override
  State<ContactInfoWidget> createState() => _ContactInfoWidgetState();
}

class _ContactInfoWidgetState extends State<ContactInfoWidget> {
  String? _profileImagePath;

  Future<void> _loadProfileImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('profile_image_path');
    final currentUser = User.storyUser.firstWhere(
      (user) => user.id == '0',
      orElse: () => User.storyUser.first,
    );
    setState(() {
      _profileImagePath = imagePath ?? currentUser.profileImage;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadProfileImagePath();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size screenSize = MediaQuery.sizeOf(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => widget.isNeedToLeadingIcon
            ? context.push(RouteCenter.ProfileScreen).then((_) {
                _loadProfileImagePath();
              })
            : context.push(RouteCenter.chatScreen),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: widget.verticalPadding),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.sizeOf(context).height * 0.015,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(shape: BoxShape.circle),
                child:
                    _profileImagePath != null &&
                        File(_profileImagePath!).existsSync()
                    ? CircleAvatar(
                        radius: 35,
                        backgroundImage: FileImage(File(_profileImagePath!)),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.grey,
                        ),
                      ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const SizedBox(height: 15),
                  Text(
                    widget.contact.name,
                    style: textTheme.titleLarge!.copyWith(
                      color: AppTheme.black,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.contact.bio,
                    style: textTheme.bodySmall!.copyWith(
                      color: AppTheme.gray,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Spacer(),
              widget.isNeedToLeadingIcon
                  ? GestureDetector(
                      onTap: () => context.push(RouteCenter.qrCode),
                      child: SvgPicture.asset(
                        "assets/svg/qrCode.svg",
                        width: screenSize.width * 0.027,
                        height: screenSize.height * 0.027,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
