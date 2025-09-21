import 'dart:io';

import 'package:chatbox/core/route/route_center.dart';
import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/features/home/data/models/storymodels/user.dart';
import 'package:chatbox/features/home/presentation/widgets/scrollablefrienditem.dart';
import 'package:chatbox/features/home/presentation/widgets/storywid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageTab extends StatefulWidget {
  const MessageTab({super.key, required this.pageController});
  final PageController pageController;

  @override
  State<MessageTab> createState() => _MessageTabState();
}

class _MessageTabState extends State<MessageTab> {
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
    var size = MediaQuery.of(context).size;
    double verticalSpacing = size.height * 0.025;

    return Scaffold(
      backgroundColor: AppTheme.black,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Colors.teal,
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
          onPressed: () {
            context.push(RouteCenter.createGroup);
          },
          icon: Icon(Icons.group_add, color: Colors.white, size: 28),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            /// ====== Header ======
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: verticalSpacing,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {},
                    child: SvgPicture.asset(
                      'assets/svg/Group 370.svg',
                      height: size.height * 0.05,
                    ),
                  ),
                  Text(
                    'Home',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.push(RouteCenter.profileScreen).then((_) {
                        _loadProfileImagePath();
                      });
                    },
                    borderRadius: BorderRadius.circular(15),
                    child:
                        _profileImagePath != null &&
                            File(_profileImagePath!).existsSync()
                        ? CircleAvatar(
                            radius: size.width * 0.055,
                            backgroundImage: FileImage(
                              File(_profileImagePath!),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[300],
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 45,
                              color: Colors.grey,
                            ),
                          ),
                  ),
                ],
              ),
            ),

            /// ====== Stories and Message List ======
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    StoryDisplay(pageController: widget.pageController),
                    SizedBox(height: verticalSpacing),
                    Container(
                      padding: EdgeInsets.only(top: size.height * 0.015),
                      decoration: BoxDecoration(
                        color: AppTheme.primary,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 10,
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: size.width * 0.1,
                            height: size.height * 0.004,
                            margin: EdgeInsets.symmetric(
                              vertical: size.height * 0.01,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.01,
                              vertical: size.height * 0.01,
                            ),
                            shrinkWrap: true,
                            itemCount: 15,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: size.height * 0.02),
                            itemBuilder: (context, index) {
                              return CustomSlidableMessageItem(
                                onTap: () {
                                  context.push(RouteCenter.chatScreen);
                                },
                                onSwipeBack: () {
                                  widget.pageController.animateToPage(
                                    0,
                                    duration: const Duration(milliseconds: 350),
                                    curve: Curves.easeOutCubic,
                                  );
                                },
                                edgeWidth: 150,
                                backSwipeThreshold: 160,
                                onMute: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Muted Ghareeb'),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                },
                                onDelete: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Deleted Ghareeb'),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
