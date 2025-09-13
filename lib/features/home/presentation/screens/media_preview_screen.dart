import 'dart:io';
import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/features/home/data/models/storymodels/story.dart';
import 'package:chatbox/features/home/data/models/storymodels/text.dart';
import 'package:chatbox/features/home/presentation/screens/hero_edit.dart';
import 'package:chatbox/features/home/presentation/screens/photoedit.dart';
import 'package:chatbox/features/home/presentation/widgets/draggable_tetx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:video_player/video_player.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';

class MediaPreviewScreen extends StatefulWidget {
  final String mediaPath;
  final MediaType mediaType;
  final Function(String) onSave;

  const MediaPreviewScreen({
    super.key,
    required this.mediaPath,
    required this.mediaType,
    required this.onSave,
  });

  @override
  State<MediaPreviewScreen> createState() => _MediaPreviewScreenState();
}

class _MediaPreviewScreenState extends State<MediaPreviewScreen>
    with TickerProviderStateMixin {
  VideoPlayerController? _videoPlayerController;
  bool _isVideoInitialized = false;
  bool _isPlaying = false;
  String? _videoError;

  final ScreenshotController _screenshotController = ScreenshotController();
  final List<TextOverlay> _textOverlays = [];

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  bool _isProcessing = false;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeMedia();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeController.forward();
    _slideController.forward();
  }

  Future<void> _initializeMedia() async {
    if (widget.mediaType == MediaType.video) {
      await _initializeVideo();
    }
  }

  Future<void> _initializeVideo() async {
    try {
      _videoPlayerController = VideoPlayerController.file(
        File(widget.mediaPath),
      );

      _videoPlayerController!.addListener(() {
        if (_videoPlayerController!.value.hasError) {
          setState(() {
            _videoError = 'Video playback error';
          });
        }

        if (mounted) {
          setState(() {
            _isPlaying = _videoPlayerController!.value.isPlaying;
          });
        }
      });

      await _videoPlayerController!.initialize();

      if (mounted) {
        setState(() {
          _isVideoInitialized = true;
        });

        await _videoPlayerController!.play();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _videoError = 'Failed to load video';
        });
      }
    }
  }

  Future<void> _playPauseVideo() async {
    if (_videoPlayerController == null || !_isVideoInitialized) return;

    try {
      if (_videoPlayerController!.value.isPlaying) {
        await _videoPlayerController!.pause();
      } else {
        await _videoPlayerController!.play();
      }
      HapticFeedback.selectionClick();
    } catch (e) {
      setState(() {
        _videoError = 'Playback control error';
      });
    }
  }

  void _addTextOverlay(Offset position) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,

      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder:
          (
            BuildContext buildContext,
            Animation animation,
            Animation secondaryAnimation,
          ) {
            return TextEditScreen(
              imageName: widget.mediaPath,
              onTextSubmitted:
                  (text, color, fontSize, backgroundCount, currentTextAlign) {
                    setState(() {
                      _textOverlays.add(
                        TextOverlay(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          text: text,
                          position: position,
                          color: color,
                          fontSize: fontSize,
                          backgroundClickCount: backgroundCount,
                          textAlign: currentTextAlign,
                        ),
                      );
                    });
                    Navigator.of(buildContext).pop();
                  },
            );
          },
      transitionBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  ),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
    );
  }

  void _editTextOverlay(TextOverlay overlay) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,

      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder:
          (
            BuildContext buildContext,
            Animation animation,
            Animation secondaryAnimation,
          ) {
            return TextEditScreen(
              imageName: widget.mediaPath,
              initialText: overlay.text,
              initialColor: overlay.color,
              initialFontSize: overlay.fontSize,
              initialBackgroundCount: overlay.backgroundClickCount,
              onTextSubmitted:
                  (text, color, fontSize, backgroundCount, currentTextAlign) {
                    setState(() {
                      overlay.text = text;
                      overlay.color = color;
                      overlay.fontSize = fontSize;
                      overlay.backgroundClickCount = backgroundCount;
                      overlay.textAlign = currentTextAlign;
                    });
                    Navigator.of(buildContext).pop();
                  },
            );
          },
      transitionBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  ),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
    );
  }

  void _deleteTextOverlay(String id) {
    setState(() {
      _textOverlays.removeWhere((overlay) => overlay.id == id);
    });
    HapticFeedback.mediumImpact();
  }

  Future<void> _saveMedia() async {
    if (_isProcessing) return;

    setState(() => _isProcessing = true);

    try {
      if (widget.mediaType == MediaType.image) {
        final imageBytes = await _screenshotController.capture(
          delay: const Duration(milliseconds: 100),
          pixelRatio: 2.0,
        );

        if (imageBytes != null) {
          final directory = await getApplicationDocumentsDirectory();
          final fileName =
              'edited_${DateTime.now().millisecondsSinceEpoch}.png';
          final imagePath = '${directory.path}/$fileName';

          final imageFile = File(imagePath);
          await imageFile.writeAsBytes(imageBytes);

          widget.onSave(imagePath);
        } else {
          widget.onSave(widget.mediaPath);
        }
      } else {
        widget.onSave(widget.mediaPath);
      }

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      debugPrint('Error saving media: $e');
      widget.onSave(widget.mediaPath);
      if (mounted) {
        Navigator.pop(context, true);
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  void _discardChanges() {
    HapticFeedback.mediumImpact();
    Navigator.pop(context, false);
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: Stack(
            children: [
              Screenshot(
                controller: _screenshotController,
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: _toggleControls,
                      onTapUp: (details) {
                        if (widget.mediaType == MediaType.image) {
                          final RenderBox renderBox =
                              context.findRenderObject() as RenderBox;
                          final localPosition = renderBox.globalToLocal(
                            details.globalPosition,
                          );
                          _addTextOverlay(localPosition);
                        }
                      },
                      child: _buildMediaContent(screenSize),
                    ),

                    if (widget.mediaType == MediaType.image)
                      ..._textOverlays.map(
                        (overlay) => DraggableTextOverlay(
                          key: ValueKey(overlay.id),
                          width: screenSize.width,
                          overlay: overlay,
                          onTap: () => _editTextOverlay(overlay),
                          onLongPress: () => _deleteTextOverlay(overlay.id),
                          onPositionChanged: (newPosition) {
                            setState(() {
                              overlay.position = newPosition;
                            });
                          },
                        ),
                      ),
                  ],
                ),
              ),
              if (widget.mediaType == MediaType.video &&
                  _isVideoInitialized &&
                  _showControls)
                _buildVideoControls(),

              if (_showControls) _buildUIControls(screenSize),

              if (_videoError != null) _buildErrorOverlay(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMediaContent(Size screenSize) {
    if (widget.mediaType == MediaType.image) {
      return SizedBox(
        width: double.infinity,
        height: screenSize.height * 0.8,
        child: Hero(
          tag: 'media-${widget.mediaPath}',
          child: ImagePhotoViewCombo(imagePath: widget.mediaPath),
        ),
      );
    } else {
      return _buildVideoPlayer(screenSize);
    }
  }

  Widget _buildVideoPlayer(Size screenSize) {
    if (!_isVideoInitialized || _videoPlayerController == null) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: screenSize.height * 0.8,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.black,
      ),
      clipBehavior: Clip.antiAlias,
      child: Hero(
        tag: 'media-${widget.mediaPath}',
        child: AspectRatio(
          aspectRatio: _videoPlayerController!.value.aspectRatio,
          child: VideoPlayer(_videoPlayerController!),
        ),
      ),
    );
  }

  Widget _buildVideoControls() {
    return Center(
      child: GestureDetector(
        onTap: _playPauseVideo,
        child: AnimatedOpacity(
          opacity: _showControls ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUIControls(Size screenSize) {
    return SlideTransition(
      position: _slideAnimation,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildControlButton(
                    icon: Icons.close,
                    onTap: _discardChanges,
                  ),
                  if (widget.mediaType == MediaType.image)
                    _buildControlButton(
                      icon: Icons.text_fields,
                      onTap: () => _addTextOverlay(const Offset(100, 100)),
                    ),
                ],
              ),
            ),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  icon: Icons.close,
                  label: 'Discard',
                  onTap: _discardChanges,
                  color: Colors.red,
                ),
                _buildActionButton(
                  icon: Icons.check,
                  label: 'share',
                  onTap: _saveMedia,
                  color: AppTheme.black,
                  isLoading: _isProcessing,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(25),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: onTap,
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color color,
    bool isLoading = false,
  }) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(25),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: isLoading ? null : onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isLoading)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              else
                Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorOverlay() {
    return Positioned(
      top: 100,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          _videoError!,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
