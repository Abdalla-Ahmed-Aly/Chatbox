import 'dart:io';
import 'package:chatbox/core/route/route_center.dart';
import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/core/widget/photo_open_screen.dart';
import 'package:chatbox/features/chat/presentation/cubit/get_user_Profile_state.dart';
import 'package:chatbox/features/chat/presentation/cubit/get_user_profile_cubit.dart';
import 'package:chatbox/features/profile/presentation/screens/custom_image_crop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chatbox/features/home/data/models/storymodels/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreenUser extends StatefulWidget {
  const ProfileScreenUser({super.key});

  @override
  State<ProfileScreenUser> createState() => _ProfileScreenUserState();
}

class _ProfileScreenUserState extends State<ProfileScreenUser> {
  final ImagePicker _picker = ImagePicker();
  File? _profileImage;
  User currentUser = User.storyUser.firstWhere((user) => user.id == '0');

  Future<void> pickImageFromGallery(BuildContext context) async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1080,
      maxHeight: 1080,
      imageQuality: 80,
    );
    if (image != null) {
      File imageFile = File(image.path);
      _navigateToCropScreen(context, imageFile);
    }
  }

  Future<void> pickImageFromCamera(BuildContext context) async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1080,
      maxHeight: 1080,
      imageQuality: 80,
    );
    if (image != null) {
      File imageFile = File(image.path);
      _navigateToCropScreen(context, imageFile);
    }
  }

  Future<void> _navigateToCropScreen(
    BuildContext context,
    File imageFile,
  ) async {
    final result = await Navigator.push<File?>(
      context,
      MaterialPageRoute(
        builder: (context) => CustomImageCropScreen(
          cameraImage: imageFile,
          onCropped: (croppedFile) {
            if (croppedFile != null) {
              print('Image cropped successfully: ${croppedFile.path}');
            }
          },
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _profileImage = result;
      });

      final updatedUser = User(
        id: currentUser.id,
        username: currentUser.username,
        profileImage: result.path,
        stories: currentUser.stories,
        bio: currentUser.bio,
        friends: currentUser.friends,
        lastSeen: currentUser.lastSeen,
        onlineStatus: currentUser.onlineStatus,
        chatRooms: currentUser.chatRooms,
      );
      currentUser = updatedUser;
      await _saveProfileImagePath(result.path);

      Navigator.pop(context);
    }
  }

  Future<void> _saveProfileImagePath(String imagePath) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image_path', imagePath);
    final index = User.storyUser.indexWhere(
      (user) => user.id == currentUser.id,
    );
    if (index != -1) {
      User.storyUser[index] = currentUser;
    }
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('profile_image_path');
    if (imagePath != null && File(imagePath).existsSync()) {
      setState(() {
        _profileImage = File(imagePath);
        currentUser = User(
          id: currentUser.id,
          username: currentUser.username,
          profileImage: imagePath,
          stories: currentUser.stories,
          bio: currentUser.bio,
          friends: currentUser.friends,
          lastSeen: currentUser.lastSeen,
          onlineStatus: currentUser.onlineStatus,
          chatRooms: currentUser.chatRooms,
        );
      });
    }
  }

  void _removeProfileImage() async {
    setState(() {
      _profileImage = null;
    });
    Navigator.pop(context);

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('profile_image_path');
    final updatedUser = User(
      id: currentUser.id,
      username: currentUser.username,
      profileImage: 'assets/images/model1.png',
      stories: currentUser.stories,
      bio: currentUser.bio,
      friends: currentUser.friends,
      lastSeen: currentUser.lastSeen,
      onlineStatus: currentUser.onlineStatus,
      chatRooms: currentUser.chatRooms,
    );
    currentUser = updatedUser;

    final index = User.storyUser.indexWhere(
      (user) => user.id == currentUser.id,
    );
    if (index != -1) {
      User.storyUser[index] = currentUser;
    }
  }

  void showPickingOptions(double height, BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          color: AppTheme.primary,
        ),
        height: height * 0.35,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildControlButton(
                  onTap: () => Navigator.pop(context),
                  icon: Icons.close,
                ),
                Text(
                  'Profile Photo',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildControlButton(
                  onTap: _removeProfileImage,
                  icon: Icons.delete_outline_rounded,
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildPickingOptions(
              onTap: () => pickImageFromCamera(context),
              context,
              icon: Icons.camera_alt_outlined,
              label: 'Camera',
            ),
            _buildPickingOptions(
              onTap: () => pickImageFromGallery(context),
              context,
              icon: Icons.image,
              label: 'Gallery',
            ),
            _buildPickingOptions(
              onTap: () {
                Navigator.pop(context);
              },
              context,
              icon: Icons.emoji_emotions,
              label: 'Avatar',
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  @override
  Widget build(BuildContext context) {
    Size screenDim = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppTheme.black,
      body: BlocBuilder<GetUserProfileCubit, GetUserProfileState>(
        builder: (context, state) {
          // if (state is ProfileLoading) {
          //   return const Center(child: CircularProgressIndicator());
          // } else
          if (state is GetUserProfileSuccess) {
            final currentUser = state.data;
            // print(currentUser.address);

            return Column(
              children: [
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: AppTheme.primary,
                              size: 30,
                            ),
                          ),
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => PhotoOpenScreen(
                                        imageUrl: currentUser
                                            .profilePicture
                                            .secureUrl,
                                      ),
                                    ),
                                  );
                                },
                                child: CircleAvatar(
                                  radius: screenDim.height * 0.1,
                                  backgroundImage:
                                      currentUser
                                          .profilePicture
                                          .secureUrl
                                          .isNotEmpty
                                      ? NetworkImage(
                                          currentUser.profilePicture.secureUrl,
                                        )
                                      : null,
                                  child:
                                      currentUser
                                          .profilePicture
                                          .secureUrl
                                          .isEmpty
                                      ? Icon(
                                          Icons.person,
                                          size: screenDim.height * 0.2,
                                          color: Colors.grey,
                                        )
                                      : null,
                                ),
                              ),

                              Text(
                                currentUser.username,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),

                              Text(
                                currentUser.bio,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: AppTheme.gray),
                              ),
                            ],
                          ),
                          const Spacer(flex: 2),
                        ],
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildControlButton(
                      onTap: () {
                        context.pop();
                      },
                      svgPath: 'assets/svg/Group (1).svg',
                    ),
                    _buildControlButton(
                      onTap: () {
                        context.push(RouteCenter.ringScreen);
                      },
                      svgPath: 'assets/svg/Group (2).svg',
                      width: 25,
                      height: 25,
                    ),
                    _buildControlButton(
                      onTap: () {
                        context.push(RouteCenter.ringScreen);
                      },
                      svgPath: 'assets/svg/Rectangle 77.svg',
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: screenDim.height * 0.015),
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
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: screenDim.width * 0.1,
                                  height: screenDim.height * 0.005,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 30),
                            _buildUserInfoItem(
                              context,
                              label: 'Display Name',
                              info: currentUser.username,
                              icon: Icons.person,
                            ),
                            const SizedBox(height: 20),

                            _buildUserInfoItem(
                              context,
                              label: 'Email Address',
                              info: currentUser.email,
                              icon: Icons.email_outlined,
                            ),
                            const SizedBox(height: 20),

                            _buildUserInfoItem(
                              context,
                              label: 'Address',
                              info: currentUser.address,
                              icon: Icons.location_on_outlined,
                            ),
                            const SizedBox(height: 20),

                            _buildUserInfoItem(
                              context,
                              label: 'Phone Number',
                              info: currentUser.phoneNumber,
                              icon: Icons.phone,
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is GetUserProfileFailure) {
            return Center(child: Text("Error: ${state.error}"));
          } else {
            return Center(child: Text("Error: $state"));
          }
        },
      ),
    );
  }

  Widget _buildControlButton({
    String? svgPath,
    IconData? icon = Icons.hourglass_empty,
    required VoidCallback onTap,
    double height = 30,
    double width = 30,
  }) {
    return Container(
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppTheme.darkGreen,
      ),
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: svgPath != null
                ? SvgPicture.asset(svgPath, height: height, width: width)
                : Icon(icon, size: 30, color: AppTheme.primary),
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfoItem(
    BuildContext context, {
    required String label,
    required String info,
    IconData? icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: AppTheme.darkGreen.withOpacity(0.1),
            child: Icon(
              icon ?? Icons.info_outline,
              color: AppTheme.darkGreen,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.gray,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  info,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPickingOptions(
    BuildContext context, {
    required VoidCallback onTap,
    required String label,
    required IconData icon,
  }) {
    return Material(
      color: Colors.transparent,
      shape: const BeveledRectangleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const BeveledRectangleBorder(),
        splashColor: AppTheme.darkGreen.withOpacity(0.5),
        highlightColor: AppTheme.darkGreen.withOpacity(0.5),
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              const SizedBox(width: 10),
              Icon(icon, size: 30, color: AppTheme.darkGreen),
              const SizedBox(width: 10),
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(color: AppTheme.darkGreen),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
