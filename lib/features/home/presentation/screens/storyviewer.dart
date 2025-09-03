import 'dart:io';
import 'package:chatbox/core/constants/story_constants/storyconstants.dart';
import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/features/home/data/models/storymodels/story.dart';
import 'package:chatbox/features/home/data/models/storymodels/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:video_player/video_player.dart';

class StoryViewer extends StatefulWidget {
  final List<User> users;
  final int initialUserIndex;
  final int initialStoryIndex;
  final VoidCallback? onClose;

  const StoryViewer({
    super.key,
    required this.users,
    this.initialUserIndex = 0,
    this.initialStoryIndex = 0,
    this.onClose,
  });

  @override
  State<StoryViewer> createState() => _StoryViewerState();
}

class _StoryViewerState extends State<StoryViewer>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _progressController;
  Timer? _storyTimer;
  VideoPlayerController? _videoController;

  int _currentUserIndex = 0;
  int _currentStoryIndex = 0;
  bool _isPaused = false;
  bool _videoInitializing = false;

  final Set<String> _likedStories = {};

  @override
  void initState() {
    super.initState();
    _currentUserIndex = widget.initialUserIndex;
    _currentStoryIndex = widget.initialStoryIndex;

    _pageController = PageController(initialPage: _currentUserIndex);
    _progressController = AnimationController(
      vsync: this,
      duration: _getCurrentStory().duration,
    );

    _initializeCurrentStory();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void dispose() {
    _storyTimer?.cancel();
    _progressController.dispose();
    _pageController.dispose();
    _disposeVideoController();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  Story _getCurrentStory() {
    return widget.users[_currentUserIndex].stories[_currentStoryIndex];
  }

  User _getCurrentUser() {
    return widget.users[_currentUserIndex];
  }

  Future<void> _initializeCurrentStory() async {
    final story = _getCurrentStory();

    await _disposeVideoController();

    if (story.mediaType == MediaType.video) {
      await _initializeVideoController(story.mediaUrl);
    } else {
      _startStoryTimer();
    }
  }

  Future<void> _initializeVideoController(String videoPath) async {
    setState(() {
      _videoInitializing = true;
    });

    try {
      _videoController = VideoPlayerController.file(File(videoPath));

      await _videoController!.initialize();
      final videoDuration = _videoController!.value.duration;
      _progressController.duration = videoDuration;

      await _videoController!.play();
      _startStoryTimer();

      setState(() {
        _videoInitializing = false;
      });
    } catch (e) {
      print('Error initializing video: $e');
      setState(() {
        _videoInitializing = false;
      });

      _startStoryTimer();
    }
  }

  Future<void> _disposeVideoController() async {
    try {
      await _videoController?.pause();
      await _videoController?.dispose();
      _videoController = null;
    } catch (e) {
      print('Error disposing video controller: $e');
    }
  }

  void _startStoryTimer() {
    _storyTimer?.cancel();

    final story = _getCurrentStory();
    Duration duration = story.duration;

    if (story.mediaType == MediaType.video && _videoController != null) {
      duration = _videoController!.value.duration;
    }

    _progressController.duration = duration;
    _progressController.forward(from: 0);

    _storyTimer = Timer(duration, () {
      _nextStory();
    });
  }

  void _pauseStory() {
    setState(() {
      _isPaused = true;
    });
    _storyTimer?.cancel();
    _progressController.stop();
    _videoController?.pause();
  }

  void _resumeStory() {
    setState(() {
      _isPaused = false;
    });

    final story = _getCurrentStory();
    Duration totalDuration = story.duration;

    if (story.mediaType == MediaType.video && _videoController != null) {
      totalDuration = _videoController!.value.duration;
    }

    final remainingTime = totalDuration * (1 - _progressController.value);

    final adjustedRemainingTime = remainingTime.inMilliseconds > 100
        ? remainingTime
        : const Duration(milliseconds: 100);

    _progressController.duration = adjustedRemainingTime;
    _progressController.forward();
    _videoController?.play();

    _storyTimer = Timer(adjustedRemainingTime, () {
      _nextStory();
    });
  }

  void _nextStory() {
    if (_currentStoryIndex < _getCurrentUser().stories.length - 1) {
      setState(() {
        _currentStoryIndex++;
      });
      _initializeCurrentStory();
    } else {
      _nextUser();
    }
  }

  void _previousStory() {
    if (_currentStoryIndex > 0) {
      setState(() {
        _currentStoryIndex--;
      });
      _initializeCurrentStory();
    } else {
      _previousUser();
    }
  }

  void _nextUser() {
    if (_currentUserIndex < widget.users.length - 1) {
      setState(() {
        _currentUserIndex++;
        _currentStoryIndex = 0;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _initializeCurrentStory();
    } else {
      _closeViewer();
    }
  }

  void _previousUser() {
    if (_currentUserIndex > 0) {
      setState(() {
        _currentUserIndex--;
        _currentStoryIndex = _getCurrentUser().stories.length - 1;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _initializeCurrentStory();
    }
  }

  void _closeViewer() {
    widget.onClose?.call();
    Navigator.of(context).pop();
  }

  String _getPublishedTime(DateTime dateTime) {
    String publishedAt = timeago.format(dateTime);
    return publishedAt;
  }

  bool _isCurrentStoryLiked() {
    return _likedStories.contains(_getCurrentStory().id);
  }

  bool _isAssetPath(String path) {
    return path.startsWith('assets/');
  }

  void _toggleCurrentStoryLike() {
    final storyId = _getCurrentStory().id;
    setState(() {
      if (_likedStories.contains(storyId)) {
        _likedStories.remove(storyId);
      } else {
        _likedStories.add(storyId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screendim = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentUserIndex = index;
            _currentStoryIndex = 0;
          });
          _initializeCurrentStory();
        },
        itemCount: widget.users.length,
        itemBuilder: (context, userIndex) {
          return _buildStoryView(screendim);
        },
      ),
    );
  }

  Widget _buildStoryView(Size screendim) {
    final user = _getCurrentUser();
    final story = _getCurrentStory();

    return GestureDetector(
      onTapDown: (details) {
        _pauseStory();
      },
      onTapUp: (details) {
        _resumeStory();
        final screenWidth = MediaQuery.of(context).size.width;
        if (details.localPosition.dx < screenWidth / 3) {
          _previousStory();
        } else if (details.localPosition.dx > screenWidth * 2 / 3) {
          _nextStory();
        }
      },
      onTapCancel: () {
        _resumeStory();
      },
      onLongPressStart: (details) {
        _pauseStory();
      },
      onLongPressEnd: (details) {
        _resumeStory();
      },
      child: Stack(
        children: [
          SafeArea(child: _buildStoryContent(story, screendim)),

          Positioned(top: 40, left: 8, right: 8, child: _buildProgressBars()),

          Positioned(
            top: 60,
            left: 16,
            right: 16,
            child: _buildUserHeader(user),
          ),

          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: _buildBottomControls(),
          ),
        ],
      ),
    );
  }

  Widget _buildStoryContent(Story story, Size screendim) {
    switch (story.mediaType) {
      case MediaType.video:
        return _buildVideoContent(story, screendim);
      case MediaType.image:
        return _buildImageContent(story, screendim);
    }
  }

  Widget _buildVideoContent(Story story, Size screendim) {
    if (_videoInitializing) {
      return _buildLoadingState('Loading video...');
    }

    if (_videoController != null && _videoController!.value.isInitialized) {
      return _buildMediaContainer(
        screendim,
        child: AspectRatio(
          aspectRatio: _videoController!.value.aspectRatio,
          child: VideoPlayer(_videoController!),
        ),
      );
    }

    return _buildErrorState('Failed to load video');
  }

  Widget _buildImageContent(Story story, Size screendim) {
    return _buildMediaContainer(screendim, child: _buildImageWidget(story));
  }

  Widget _buildMediaContainer(Size screendim, {required Widget child}) {
    return Container(
      width: double.infinity,
      height: screendim.height * StoryContentConstants.contentHeightRatio,
      margin: const EdgeInsets.symmetric(
        horizontal: StoryContentConstants.horizontalMargin,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(StoryContentConstants.borderRadius),
      ),
      child: child,
    );
  }

  Widget _buildImageWidget(Story story) {
    if (_isAssetPath(story.mediaUrl)) {
      return Image.asset(
        story.mediaUrl,
        fit: BoxFit.cover,
        frameBuilder: _buildImageFrameBuilder,
        errorBuilder: (context, error, stackTrace) =>
            _buildErrorState('Failed to load image'),
      );
    } else {
      return Image.file(
        File(story.mediaUrl),
        fit: BoxFit.cover,
        frameBuilder: _buildImageFrameBuilder,
        errorBuilder: (context, error, stackTrace) =>
            _buildErrorState('Failed to load image'),
      );
    }
  }

  Widget _buildImageFrameBuilder(
    BuildContext context,
    Widget child,
    int? frame,
    bool wasSynchronouslyLoaded,
  ) {
    if (wasSynchronouslyLoaded) return child;

    return AnimatedOpacity(
      opacity: frame == null ? 0 : 1,
      duration: const Duration(milliseconds: 300),
      child: child,
    );
  }

  Widget _buildLoadingState(String message) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: Colors.white),
            const SizedBox(height: StoryContentConstants.errorSpacing),
            Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: StoryContentConstants.errorFontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Container(
      color: Colors.grey[900],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FaIcon(
              FontAwesomeIcons.triangleExclamation,
              color: Colors.red,
              size: StoryContentConstants.errorIconSize,
            ),
            const SizedBox(height: StoryContentConstants.errorSpacing),
            Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: StoryContentConstants.errorFontSize,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: StoryContentConstants.errorSpacing),
            TextButton(
              onPressed: () => _initializeCurrentStory(),
              child: const Text(
                'Tap to retry',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBars() {
    final user = _getCurrentUser();

    return Row(
      children: user.stories.asMap().entries.map((entry) {
        int index = entry.key;
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 1),
            height: 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1.5),
              color: Colors.white.withOpacity(0.3),
            ),
            child: AnimatedBuilder(
              animation: _progressController,
              builder: (context, child) {
                double progress = 0;
                if (index < _currentStoryIndex) {
                  progress = 1;
                } else if (index == _currentStoryIndex) {
                  progress = _progressController.value;
                }

                return LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.transparent,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                );
              },
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildUserHeader(User user) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage(user.profileImage),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.username,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Text(
                _getPublishedTime(_getCurrentStory().createdAt),
                style: TextStyle(color: AppTheme.gray, fontSize: 12),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.ellipsisVertical,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: FaIcon(FontAwesomeIcons.xmark, color: AppTheme.primary),
          onPressed: _closeViewer,
        ),
      ],
    );
  }

  Widget _buildBottomControls() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.white.withOpacity(0.5)),
            ),
            child: Text(
              'Send message',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        IconButton(
          icon: FaIcon(
            _isCurrentStoryLiked()
                ? FontAwesomeIcons.solidHeart
                : FontAwesomeIcons.heart,
            color: _isCurrentStoryLiked() ? AppTheme.red : AppTheme.primary,
          ),
          onPressed: _toggleCurrentStoryLike,
        ),
        IconButton(
          icon: FaIcon(FontAwesomeIcons.paperPlane, color: AppTheme.primary),
          onPressed: () {},
        ),
      ],
    );
  }
}
