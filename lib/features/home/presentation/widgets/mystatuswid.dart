import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/features/home/data/models/storymodels/story_user.dart';
import 'package:chatbox/features/home/presentation/screens/storyviewer.dart';
import 'package:chatbox/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:chatbox/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyStatus extends StatelessWidget {
  final String username;
  final String image;
  final double radius;
  final bool hasNewStory;
  final bool isViewed;
  final PageController pageController;

  const MyStatus({
    super.key,
    this.username = 'Ghareeb',
    this.image = 'assets/images/model1.png',
    this.radius = 25,
    this.hasNewStory = false,
    this.isViewed = false,
    required this.pageController,
  });

  Future<String> _loadProfileImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('profile_image_path');
    final currentUser = StoryUser.storyUser.firstWhere(
      (user) => user.userId == '0',
      orElse: () => StoryUser.storyUser.first,
    );
    return imagePath ?? currentUser.profileImage;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () {
        isViewed == true;
        hasNewStory
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StoryViewer(
                    users: StoryUser.storyUser,
                    onClose: () {
                      print('Story viewer closed');
                    },
                  ),
                ),
              )
            : pageController.animateToPage(
                0,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
        // : Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) =>
        //           StoryMakerScreen(pageController: pageController),
        //     ),
        //   );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: hasNewStory && !isViewed
                      ? const LinearGradient(
                          colors: [
                            Color(0xFFF58529),
                            Color(0xFFDD2A7B),
                            Color(0xFF8134AF),
                            Color(0xFF515BD4),
                          ],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        )
                      : null,
                  border: isViewed
                      ? Border.all(color: Colors.transparent, width: 4)
                      : null,
                  color: !hasNewStory || isViewed ? Colors.grey : null,
                ),
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppTheme.black, width: 3),
                  ),
                  child: BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileLoading) {
                        return SizedBox(
                          height: size.height * 0.068,
                          width: size.width * 0.15,
                          child: Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: AppTheme.primary,
                                strokeWidth: 4,
                              ),
                            ),
                          ),
                        );
                      } else if (state is ProfileSuccess) {
                        final profile = state.message;
                        return ClipOval(
                          child: Image.network(
                            profile.profilePicture.secureUrl,
                            fit: BoxFit.cover,
                            width: 66,
                            height: 66,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: const Icon(
                                  Icons.person,
                                  size: 66,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return Container(
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.person,
                            size: 66,
                            color: Colors.grey,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              if (!hasNewStory)
                Positioned(
                  right: -2,
                  bottom: -2,
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.primary,
                      border: Border.all(color: AppTheme.black, width: 2),
                    ),
                    child: Icon(
                      CupertinoIcons.add,
                      size: 20,
                      color: AppTheme.black,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: 70,
            child: Text(
              username,
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
