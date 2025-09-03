import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/features/home/data/models/storymodels/story.dart';
import 'package:chatbox/features/home/data/models/storymodels/user.dart';
import 'package:chatbox/features/home/presentation/screens/media_preview_screen.dart';
import 'package:chatbox/features/home/presentation/widgets/customizedcircularprogressed.dart';
import 'package:chatbox/features/home/presentation/widgets/flashAuto.dart';
import 'package:chatbox/features/home/presentation/widgets/slashed_lightning.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class NewStoryMakerScreen extends StatefulWidget {
  const NewStoryMakerScreen({
    super.key,
    required this.pageController,
    required this.onImageCaptured,
  });

  static const String routeName = '/story-maker-screen';
  final PageController pageController;
  final VoidCallback onImageCaptured;

  @override
  State<NewStoryMakerScreen> createState() => _NewStoryMakerScreenState();
}

class _NewStoryMakerScreenState extends State<NewStoryMakerScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;
  FlashMode _flashMode = FlashMode.off;

  final ImagePicker _picker = ImagePicker();
  bool _isRecording = false;
  Timer? _recordingTimer;
  int _recordingSeconds = 0;
  static const int _maxRecordingSeconds = 60;

  late AnimationController _recordingController;
  late AnimationController _scaleController;
  late AnimationController _heroAnimationController;

  String? _recordedVideoPath;
  String? _capturedImagePath;

  VideoPlayerController? _videoPlayerController;
  String? _videoError;

  bool _isDisposed = false;
  bool _isProcessingMedia = false;
  bool _isAppInBackground = false;

  bool _isGalleryOpen = false;
  bool _shouldReinitializeCamera = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeControllers();
    _initializeCamera();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (!_isCameraInitialized) return;

    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
        if (!_isGalleryOpen) {
          _isAppInBackground = true;
          _pauseCameraForBackground();
        }
        break;
      case AppLifecycleState.resumed:
        if (_isAppInBackground && !_isGalleryOpen) {
          _isAppInBackground = false;
          _resumeCameraFromBackground();
        } else if (!_isCameraInitialized && !_isGalleryOpen) {
          _shouldReinitializeCamera = true;
        }
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  Future<void> _pauseCameraForBackground() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      try {
        if (_isRecording) {
          _stopRecording();
        }
        await _cameraController!.dispose();
        _cameraController = null;
        if (mounted) {
          setState(() {
            _isCameraInitialized = false;
          });
        }
      } catch (e) {
        debugPrint('Error pausing camera for background: $e');
      }
    }
  }

  Future<void> _resumeCameraFromBackground() async {
    if (!_isDisposed && _cameras != null && _cameras!.isNotEmpty) {
      await Future.delayed(const Duration(milliseconds: 200));
      await _initializeCameraController(_cameras![0]);
    }
  }

  void _initializeControllers() {
    _recordingController = AnimationController(
      duration: Duration(seconds: _maxRecordingSeconds),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _heroAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
  }

  Future<void> _initializeCamera() async {
    if (_isDisposed) return;

    try {
      _cameras = await availableCameras();
      if (_cameras != null && _cameras!.isNotEmpty) {
        await _initializeCameraController(_cameras![0]);
      }
    } catch (e) {
      debugPrint('Error initializing camera: $e');
    }
  }

  Future<void> _initializeCameraController(CameraDescription camera) async {
    if (_isDisposed) return;

    try {
      await _cameraController?.dispose();

      _cameraController = CameraController(
        camera,
        ResolutionPreset.high,
        enableAudio: true,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await _cameraController!.initialize();
      await _cameraController!.setFlashMode(_flashMode);

      if (!_isDisposed && mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('Error initializing camera controller: $e');
    }
  }

  Future<void> _reinitializeCamera() async {
    if (_isDisposed ||
        _cameras == null ||
        _cameras!.isEmpty ||
        _isGalleryOpen) {
      return;
    }

    try {
      if (_cameraController != null) {
        await _cameraController!.dispose();
        _cameraController = null;
      }

      await Future.delayed(const Duration(milliseconds: 300));

      _cameraController = CameraController(
        _cameras![0],
        ResolutionPreset.high,
        enableAudio: true,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await _cameraController!.initialize();
      await _cameraController!.setFlashMode(_flashMode);

      if (!_isDisposed && mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('Error reinitializing camera: $e');

      if (!_isDisposed && mounted) {
        Future.delayed(const Duration(milliseconds: 1000), () {
          if (!_isDisposed && !_isCameraInitialized && !_isGalleryOpen) {
            _reinitializeCamera();
          }
        });
      }
    }
  }

  Future<void> _toggleFlash() async {
    if (_cameraController == null || _isDisposed) return;

    setState(() {
      switch (_flashMode) {
        case FlashMode.off:
          _flashMode = FlashMode.auto;
          break;
        case FlashMode.auto:
          _flashMode = FlashMode.always;
          break;
        case FlashMode.always:
          _flashMode = FlashMode.off;
          break;
        case FlashMode.torch:
          _flashMode = FlashMode.off;
          break;
      }
    });

    try {
      await _cameraController!.setFlashMode(_flashMode);
    } catch (e) {
      debugPrint('Error setting flash mode: $e');
    }
  }

  Widget _getFlashIcon() {
    switch (_flashMode) {
      case FlashMode.off:
        return SlashedLightning();
      case FlashMode.auto:
        return FlashAutoFA();
      case FlashMode.always:
        return FaIcon(FontAwesomeIcons.bolt, color: AppTheme.primary, size: 30);
      case FlashMode.torch:
        return FaIcon(
          FontAwesomeIcons.lightbulb,
          color: AppTheme.primary,
          size: 30,
        );
    }
  }

  Future<void> _pickImageFromGallery() async {
    if (_isProcessingMedia) return;

    try {
      setState(() {
        _isProcessingMedia = true;
        _isGalleryOpen = true;
      });

      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (image != null && !_isDisposed) {
        final String imagePath = image.path;
        await _navigateToMediaPreview(imagePath, MediaType.image);
      } else {
        setState(() {
          _shouldReinitializeCamera = true;
        });
      }
    } catch (e) {
      debugPrint('Error picking image from gallery: $e');
      setState(() {
        _shouldReinitializeCamera = true;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isProcessingMedia = false;
          _isGalleryOpen = false;
        });
      }
    }
  }

  Future<void> _takePicture() async {
    if (_isRecording ||
        _cameraController == null ||
        !_cameraController!.value.isInitialized ||
        _isProcessingMedia) {
      return;
    }

    try {
      setState(() => _isProcessingMedia = true);

      HapticFeedback.mediumImpact();

      await _scaleController.forward();
      _scaleController.reverse();

      final XFile imageFile = await _cameraController!.takePicture();

      if (!_isDisposed) {
        await _navigateToMediaPreview(imageFile.path, MediaType.image);
      }

      debugPrint('Picture taken: ${imageFile.path}');
    } catch (e) {
      debugPrint('Error taking picture: $e');
    } finally {
      if (mounted) setState(() => _isProcessingMedia = false);
    }
  }

  void _startRecording() async {
    if (_isRecording ||
        _cameraController == null ||
        !_cameraController!.value.isInitialized ||
        _isProcessingMedia) {
      return;
    }

    try {
      setState(() => _isProcessingMedia = true);

      await _cameraController!.startVideoRecording();

      if (!_isDisposed && mounted) {
        setState(() {
          _isRecording = true;
          _recordingSeconds = 0;
          _videoError = null;
          _isProcessingMedia = false;
        });

        await _disposeVideoPlayer();

        _scaleController.forward();
        _recordingController.reset();
        _recordingController.forward();

        HapticFeedback.mediumImpact();

        _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (!_isDisposed && mounted) {
            setState(() {
              _recordingSeconds++;
            });

            if (_recordingSeconds >= _maxRecordingSeconds) {
              _stopRecording();
            }
          }
        });
      }
    } catch (e) {
      debugPrint('Error starting video recording: $e');
      if (mounted) {
        setState(() {
          _videoError = 'Failed to start recording';
          _isProcessingMedia = false;
        });
      }
    }
  }

  void _stopRecording() async {
    if (!_isRecording || _cameraController == null) return;

    try {
      final XFile videoFile = await _cameraController!.stopVideoRecording();

      if (!_isDisposed && mounted) {
        setState(() {
          _isRecording = false;
        });

        _scaleController.reverse();
        _recordingController.stop();
        _recordingTimer?.cancel();

        HapticFeedback.lightImpact();

        debugPrint('Video recorded: ${videoFile.path}');

        final File file = File(videoFile.path);
        if (await file.exists()) {
          final int fileSize = await file.length();

          if (fileSize > 0) {
            await _navigateToMediaPreview(videoFile.path, MediaType.video);
          } else {
            setState(() {
              _videoError = 'Recorded video file is empty';
            });
          }
        } else {
          setState(() {
            _videoError = 'Recorded video file not found';
          });
        }
      }
    } catch (e) {
      debugPrint('Error stopping video recording: $e');
      if (mounted) {
        setState(() {
          _videoError = 'Failed to stop recording';
        });
      }
    }
  }

  Future<void> _navigateToMediaPreview(
    String mediaPath,
    MediaType mediaType,
  ) async {
    if (_isDisposed) return;

    await _pauseCamera();

    await _heroAnimationController.forward();

    if (!mounted) return;

    final result = await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            MediaPreviewScreen(
              mediaPath: mediaPath,
              mediaType: mediaType,
              onSave: (String savedPath) =>
                  _handleMediaSave(savedPath, mediaType),
            ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(0.0, 1.0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  ),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );

    await _resumeCamera();

    _heroAnimationController.reverse();

    if (result == true) {
      widget.onImageCaptured();
    }
  }

  Future<void> _pauseCamera() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      try {
        if (_isRecording) {
          _stopRecording();
        }

        setState(() {
          _videoError = null;
        });

        final controller = _cameraController;
        _cameraController = null;

        if (mounted) {
          setState(() {
            _isCameraInitialized = false;
          });
        }

        await controller!.dispose();

        await Future.delayed(const Duration(milliseconds: 50));
      } catch (e) {
        debugPrint('Error pausing camera: $e');
      }
    }
  }

  Future<void> _resumeCamera() async {
    if (_isDisposed || _cameras == null || _cameras!.isEmpty) return;

    try {
      await Future.delayed(const Duration(milliseconds: 200));

      if (_cameraController == null) {
        await _initializeCameraController(_cameras![0]);
      }
    } catch (e) {
      debugPrint('Error resuming camera: $e');

      Future.delayed(const Duration(milliseconds: 500), () {
        if (!_isDisposed && mounted && _cameraController == null) {
          _initializeCameraController(_cameras![0]);
        }
      });
    }
  }

  void _handleMediaSave(String mediaPath, MediaType mediaType) {
    final story = Story(
      id: _generateId(),
      mediaUrl: mediaPath,
      mediaType: mediaType,
      createdAt: DateTime.now(),
      duration: mediaType == MediaType.image
          ? Duration(seconds: 20)
          : Duration(seconds: 5),
    );

    User.storyUser[0].stories.add(story);

    widget.pageController.animateToPage(
      1,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    widget.onImageCaptured();
  }

  String _generateId() {
    final random = Random();
    final millis = DateTime.now().millisecondsSinceEpoch;
    final rand = random.nextInt(99999);
    return '$millis$rand';
  }

  Future<void> _disposeVideoPlayer() async {
    try {
      await _videoPlayerController?.pause();
      await _videoPlayerController?.dispose();
      _videoPlayerController = null;
    } catch (e) {
      debugPrint('Error disposing video player: $e');
    }
  }

  String _formatRecordingTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _isDisposed = true;
    WidgetsBinding.instance.removeObserver(this);
    _recordingTimer?.cancel();

    _cameraController?.dispose();
    _disposeVideoPlayer();

    _recordingController.dispose();
    _scaleController.dispose();
    _heroAnimationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _heroAnimationController,
            builder: (context, child) {
              return Transform.scale(
                scale: 1.0 - (_heroAnimationController.value * 0.1),
                child: _buildMainContent(screenSize),
              );
            },
          ),

          if (_videoError != null) _buildErrorOverlay(),

          _buildUIOverlay(screenSize),
        ],
      ),
    );
  }

  Widget _buildMainContent(Size screenSize) {
    if (_isGalleryOpen) {
      return _buildCameraPreview(screenSize);
    }

    if (_isCameraInitialized && _cameraController != null) {
      return SizedBox(
        height: screenSize.height * 0.8,
        child: _buildCameraPreview(screenSize),
      );
    } else {
      return _buildLoadingPreview(screenSize);
    }
  }

  Widget _buildCameraPreview(Size screenSize) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      if (_shouldReinitializeCamera && !_isGalleryOpen) {
        _reinitializeCamera();
        _shouldReinitializeCamera = false;
      }

      return Container(
        width: double.infinity,
        height: screenSize.height * 0.8,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.black,
        ),
        child: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: screenSize.height * 0.8,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
      clipBehavior: Clip.antiAlias,
      child: CameraPreview(_cameraController!),
    );
  }

  Widget _buildLoadingPreview(Size screenSize) {
    return Container(
      width: double.infinity,
      height: screenSize.height * 0.8,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.black,
      ),
      child: const Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }

  Widget _buildErrorOverlay() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 100,
      left: 20,
      right: 20,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
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

  Widget _buildUIOverlay(Size screenSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTopControls(),

          if (_isRecording) _buildRecordingTimer(),

          const Spacer(),

          _buildBottomControls(),
        ],
      ),
    );
  }

  Widget _buildTopControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildControlButton(
          icon: FontAwesomeIcons.xmark,
          onTap: () {
            if (_capturedImagePath != null || _recordedVideoPath != null) {
              widget.onImageCaptured();
            }
            widget.pageController.animateToPage(
              1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
        _buildControlButton(child: _getFlashIcon(), onTap: _toggleFlash),
        _buildControlButton(icon: FontAwesomeIcons.gear, onTap: () {}),
      ],
    );
  }

  Widget _buildControlButton({
    IconData? icon,
    Widget? child,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.black.withOpacity(0.3),
          ),
          child: Center(
            child: child ?? FaIcon(icon!, color: Colors.white, size: 24),
          ),
        ),
      ),
    );
  }

  Widget _buildRecordingTimer() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _formatRecordingTime(_recordingSeconds),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (!_isRecording && !_isProcessingMedia)
              _buildToolButton(
                icon: FontAwesomeIcons.solidImage,
                onTap: _pickImageFromGallery,
              )
            else
              const SizedBox(width: 60),

            _buildCaptureButton(),

            _buildToolButton(icon: FontAwesomeIcons.layerGroup, onTap: () {}),
          ],
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildToolButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.black.withOpacity(0.3),
          ),
          child: Center(child: FaIcon(icon, color: Colors.white, size: 28)),
        ),
      ),
    );
  }

  Widget _buildCaptureButton() {
    return GestureDetector(
      onTap: _takePicture,
      onLongPressStart: (_) => _startRecording(),
      onLongPressEnd: (_) => _stopRecording(),
      child: AnimatedBuilder(
        animation: Listenable.merge([_recordingController, _scaleController]),
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 + (_scaleController.value * 0.1),
            child: Container(
              width: _isRecording ? 100 : 80,
              height: _isRecording ? 100 : 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 4,
                  color: _isRecording ? Colors.transparent : Colors.white,
                ),
              ),
              child: Stack(
                children: [
                  if (_isRecording)
                    CustomPaint(
                      size: const Size(100, 100),
                      painter: GradientCircularProgressPainter(
                        progress: _recordingController.value,
                        strokeWidth: 4,
                      ),
                    ),

                  Center(
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: _isRecording
                          ? const Center(
                              child: FaIcon(
                                FontAwesomeIcons.stop,
                                color: Colors.red,
                                size: 24,
                              ),
                            )
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
