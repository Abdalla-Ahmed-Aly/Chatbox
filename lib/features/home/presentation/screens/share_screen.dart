import 'dart:io';
import 'package:chatbox/core/route/route_center.dart';
import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/core/utils/app_snack_bars.dart';
import 'package:chatbox/core/widget/custom_button.dart';
import 'package:chatbox/features/home/data/models/storymodels/post_story_request.dart';
import 'package:chatbox/features/home/presentation/cubit/upload_story/upload_story_cubit.dart';
import 'package:chatbox/features/home/presentation/cubit/upload_story/upload_story_states.dart';
import 'package:chatbox/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:chatbox/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PhotoShareScreen extends StatefulWidget {
  final String imagePath;
  final String heroTag;
  final PageController pageController;

  const PhotoShareScreen({
    super.key,
    required this.imagePath,
    required this.heroTag,
    required this.pageController,
  });

  @override
  State<PhotoShareScreen> createState() => _PhotoShareScreenState();
}

class _PhotoShareScreenState extends State<PhotoShareScreen>
    with TickerProviderStateMixin {
  late PanelController _panelController;
  double _photoScale = 1.0;
  double _overlayOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    _panelController = PanelController();
  }

  void _onPanelSlide(double position) {
    setState(() {
      _photoScale = 1.0 - (position * 0.2);

      _overlayOpacity = position * 0.3;
    });

    if (position == 0.0 && mounted) {
      Navigator.of(context).pop();
    }
  }

  Widget _buildShareOption({
    required Widget icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool showArrow = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              icon,
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (subtitle.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(color: Colors.grey[400], fontSize: 14),
                      ),
                    ],
                  ],
                ),
              ),
              if (showArrow)
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[400],
                  size: 16,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPanelContent(Size size) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 20),
            height: 4,
            width: 36,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                Text(
                  'Share',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          _buildShareOption(
            icon: BlocBuilder<ProfileCubit, ProfileState>(
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
                  return InkWell(
                    onTap: () {
                      context.push(RouteCenter.profileScreen).then((_) {
                        // _loadProfileImagePath();
                      });
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: CircleAvatar(
                      radius: size.width * 0.064,
                      backgroundImage: NetworkImage(
                        profile.profilePicture.secureUrl,
                      ),
                    ),
                  );
                } else {
                  return Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 45,
                      color: Colors.grey,
                    ),
                  );
                }
              },
            ),
            title: 'Your story',
            subtitle: 'And Facebook story',
            onTap: () {},
          ),

          _buildShareOption(
            icon: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.star, color: Colors.white, size: 24),
            ),
            title: 'Close Friends',
            subtitle: '21 people',
            onTap: () {},
          ),

          _buildShareOption(
            icon: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[700],
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send, color: Colors.white, size: 24),
            ),
            title: 'Message',
            subtitle: '',
            onTap: () {},
            showArrow: true,
          ),

          const SizedBox(height: 32),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: BlocConsumer<UploadStoryCubit, UploadStoryState>(
                listener: (context, state) {
                  if (state is UploadStorySuccess) {
                    context.push(RouteCenter.home);
                    AppSnackBars.showSuccessSnackBar(
                      context: context,
                      message: state.response.success.toString(),
                    );
                  } else if (state is UploadStoryFailure) {
                    AppSnackBars.showErrorSnackBar(
                      context: context,
                      message: state.error.toString(),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is UploadStoryLoading) {}
                  return AbsorbPointer(
                    absorbing: state is UploadStoryLoading,
                    child: CustomButton(
                      onPressed: () {
                        context.read<UploadStoryCubit>().uploadStory(
                          UploadStoryRequest(file: File(widget.imagePath)),
                        );
                      },
                      isLoading: state is UploadStoryLoading,
                      text: "Share Story",
                      buttonColor: AppTheme.lightGreen,
                      textColor: AppTheme.primary,
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SlidingUpPanel(
        controller: _panelController,
        minHeight: 0,
        maxHeight: MediaQuery.of(context).size.height * 0.6,
        defaultPanelState: PanelState.OPEN,
        backdropEnabled: true,
        backdropOpacity: 0.0,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        onPanelSlide: _onPanelSlide,
        panel: _buildPanelContent(size),
        body: Stack(
          children: [
            Transform.scale(
              scale: _photoScale,
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Hero(
                  tag: widget.heroTag,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(File(widget.imagePath)),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              color: Colors.black.withOpacity(_overlayOpacity),
              width: double.infinity,
              height: double.infinity,
            ),

            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              left: 16,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
