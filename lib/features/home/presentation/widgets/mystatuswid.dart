import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/features/home/data/models/storymodels/story_user.dart';
import 'package:chatbox/features/home/presentation/screens/storyviewer.dart';
import 'package:chatbox/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:chatbox/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

class MyStatus extends StatefulWidget {
  final String username;
  final String image;
  final double radius;
  final bool hasNewStory;
  final bool isViewed;
  final bool isUploading;
  final PageController pageController;
  final List<StoryUser> storyUsers;

  const MyStatus({
    super.key,
    this.username = 'Ghareeb',
    this.image = 'assets/images/model1.png',
    this.radius = 25,
    this.hasNewStory = false,
    this.isViewed = false,
    this.isUploading = false,
    required this.pageController,
    required this.storyUsers,
  });

  @override
  State<MyStatus> createState() => _MyStatusState();
}

class _MyStatusState extends State<MyStatus>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    if (widget.isUploading) {
      _rotationController.repeat();
    }
  }

  @override
  void didUpdateWidget(MyStatus oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isUploading && !oldWidget.isUploading) {
      _rotationController.repeat();
    } else if (!widget.isUploading && oldWidget.isUploading) {
      _rotationController.stop();
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () {
        widget.hasNewStory
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StoryViewer(
                    users: widget.storyUsers,
                    onClose: () {
                      print('Story viewer closed');
                    },
                  ),
                ),
              )
            : widget.pageController.animateToPage(
                0,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              if (widget.isUploading)
                AnimatedBuilder(
                  animation: _rotationController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _rotationController.value * 2 * math.pi,
                      child: CustomPaint(
                        size: const Size(74, 74),
                        painter: RotatingBorderPainter(),
                      ),
                    );
                  },
                )
              else
                Container(
                  width: 74,
                  height: 74,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: widget.hasNewStory && !widget.isViewed
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
                    border: widget.isViewed
                        ? Border.all(color: Colors.transparent, width: 4)
                        : null,
                    color: !widget.hasNewStory || widget.isViewed
                        ? Colors.grey
                        : null,
                  ),
                ),
              // Inner container with profile image
              Container(
                width: 74,
                height: 74,
                alignment: Alignment.center,
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
              widget.username,
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

class RotatingBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final gradientPaint = Paint()
      ..shader = const SweepGradient(
        colors: [
          Color(0xFFF58529),
          Color(0xFFDD2A7B),
          Color(0xFF8134AF),
          Color(0xFF515BD4),
        ],
        startAngle: 0,
        endAngle: math.pi,
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 2),
      0,
      math.pi,
      false,
      gradientPaint,
    );

    // Draw the dark half (180 degrees)
    final darkPaint = Paint()
      ..color = Colors.grey.shade800
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 2),
      math.pi,
      math.pi,
      false,
      darkPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
