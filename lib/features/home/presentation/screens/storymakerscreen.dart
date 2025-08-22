import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/features/home/data/models/storymodels/story.dart';
import 'package:chatbox/features/home/data/models/storymodels/user.dart';
import 'package:chatbox/features/home/presentation/widgets/customizedcircularprogressed.dart';
import 'package:chatbox/features/home/presentation/widgets/flashAuto.dart';
import 'package:chatbox/features/home/presentation/widgets/slashed_lightning.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class StoryMakerScreen extends StatefulWidget {
  const StoryMakerScreen({super.key, required this.pageController});
  static final String routeName = '/story-maker-screen';
  final PageController pageController;

  @override
  State<StoryMakerScreen> createState() => _StoryMakerScreenState();
}

class _StoryMakerScreenState extends State<StoryMakerScreen>
    with TickerProviderStateMixin {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;
  bool _isRearCameraSelected = true;
  FlashMode _flashMode = FlashMode.off;
  final ImagePicker _picker = ImagePicker();
  bool _isRecording = false;
  late AnimationController _recordingController;
  late AnimationController _scaleController;
  Timer? _recordingTimer;
  int _recordingSeconds = 0;
  final int _maxRecordingSeconds = 60;
  VideoPlayerController? _videoPlayerController;
  String? _recordedVideoPath;
  String? _capturedImagePath;
  bool _isPlayingVideo = false;
  bool _videoPlayerInitializing = false;
  String? _videoError;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _recordingController = AnimationController(
      duration: Duration(seconds: _maxRecordingSeconds),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras != null && _cameras!.isNotEmpty) {
        await _initializeCameraController(_cameras![0]);
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<void> _initializeCameraController(CameraDescription camera) async {
    if (_cameraController != null) {
      await _cameraController!.dispose();
    }

    _cameraController = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: true,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    try {
      await _cameraController!.initialize();
      await _cameraController!.setFlashMode(_flashMode);
      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      print('Error initializing camera controller: $e');
    }
  }

  // Future<void> _switchCamera() async {
  //   if (_cameras == null || _cameras!.length < 2) return;

  //   setState(() {
  //     _isRearCameraSelected = !_isRearCameraSelected;
  //   });

  //   final newCamera = _isRearCameraSelected ? _cameras![0] : _cameras![1];
  //   await _initializeCameraController(newCamera);
  // }

  Future<void> _toggleFlash() async {
    if (_cameraController == null) return;

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

    await _cameraController!.setFlashMode(_flashMode);
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
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        File imageFile = File(image.path);
        setState(() {
          _capturedImagePath = imageFile.path;
          _recordedVideoPath = null;
          _isPlayingVideo = false;
        });

        await _disposeVideoPlayer();
      }
    } catch (e) {
      print('Error picking image from gallery: $e');
    }
  }

  Future<String> _getVideoFilePath() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String videoDir = path.join(appDocDir.path, 'videos');

    await Directory(videoDir).create(recursive: true);

    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    return path.join(videoDir, 'video_$timestamp.mp4');
  }

  void _startRecording() async {
    if (_isRecording ||
        _cameraController == null ||
        !_cameraController!.value.isInitialized) {
      return;
    }

    try {
      await _cameraController!.startVideoRecording();
      setState(() {
        _isRecording = true;
        _recordingSeconds = 0;
        _recordedVideoPath = null;
        _capturedImagePath = null;
        _isPlayingVideo = false;
        _videoError = null;
      });

      await _disposeVideoPlayer();

      _scaleController.forward();
      _recordingController.reset();
      _recordingController.forward();

      HapticFeedback.mediumImpact();

      _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _recordingSeconds++;
        });

        if (_recordingSeconds >= _maxRecordingSeconds) {
          _stopRecording();
        }
      });
    } catch (e) {
      print('Error starting video recording: $e');

      setState(() {
        _videoError = 'Failed to start recording: $e';
      });
    }
  }

  void _stopRecording() async {
    if (!_isRecording || _cameraController == null) return;

    try {
      final XFile videoFile = await _cameraController!.stopVideoRecording();

      setState(() {
        _isRecording = false;
        _capturedImagePath = null;
      });

      _scaleController.reverse();
      _recordingController.stop();
      _recordingTimer?.cancel();

      HapticFeedback.lightImpact();

      print('Video recorded: ${videoFile.path}');

      final File file = File(videoFile.path);
      if (await file.exists()) {
        final int fileSize = await file.length();
        print('Video file size: $fileSize bytes');

        if (fileSize > 0) {
          setState(() {
            _recordedVideoPath = videoFile.path;
          });

          await Future.delayed(Duration(milliseconds: 500));
          await _initializeVideoPlayer(videoFile.path);
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
    } catch (e) {
      print('Error stopping video recording: $e');
      setState(() {
        _videoError = 'Failed to stop recording: $e';
      });
    }
  }

  void _takePicture() async {
    if (_isRecording ||
        _cameraController == null ||
        !_cameraController!.value.isInitialized) {
      return;
    }

    try {
      HapticFeedback.mediumImpact();

      _scaleController.forward().then((_) {
        _scaleController.reverse();
      });

      final XFile imageFile = await _cameraController!.takePicture();
      setState(() {
        _capturedImagePath = imageFile.path;
        _recordedVideoPath = null;
        _isPlayingVideo = false;
        _videoError = null;
      });

      await _disposeVideoPlayer();

      print('Picture taken: ${imageFile.path}');
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  Future<void> _initializeVideoPlayer(String videoPath) async {
    try {
      setState(() {
        _videoPlayerInitializing = true;
        _videoError = null;
      });

      await _disposeVideoPlayer();

      final File videoFile = File(videoPath);
      if (!await videoFile.exists()) {
        throw Exception('Video file does not exist');
      }

      final int fileSize = await videoFile.length();
      if (fileSize == 0) {
        throw Exception('Video file is empty');
      }

      print('Initializing video player for file: $videoPath ($fileSize bytes)');

      _videoPlayerController = VideoPlayerController.file(
        videoFile,
        videoPlayerOptions: VideoPlayerOptions(
          allowBackgroundPlayback: false,
          mixWithOthers: false,
        ),
      );

      _videoPlayerController!.addListener(() {
        if (_videoPlayerController!.value.hasError) {
          print(
            'Video player error: ${_videoPlayerController!.value.errorDescription}',
          );
          setState(() {
            _videoError =
                'Playback error: ${_videoPlayerController!.value.errorDescription}';
            _videoPlayerInitializing = false;
          });
        }
      });

      await _videoPlayerController!.initialize().timeout(
        Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException(
            'Video initialization timed out',
            Duration(seconds: 10),
          );
        },
      );

      setState(() {
        _videoPlayerInitializing = false;
      });

      print('Video player initialized successfully');

      await _videoPlayerController!.play();
      setState(() {
        _isPlayingVideo = true;
      });
    } catch (e) {
      print('Error initializing video player: $e');
      setState(() {
        _videoError = 'Failed to load video: $e';
        _videoPlayerInitializing = false;
      });

      await _disposeVideoPlayer();
    }
  }

  Future<void> _disposeVideoPlayer() async {
    try {
      await _videoPlayerController?.pause();
      await _videoPlayerController?.dispose();
      _videoPlayerController = null;
    } catch (e) {
      print('Error disposing video player: $e');
    }
  }

  String generateId() {
    final random = Random();
    final millis = DateTime.now().millisecondsSinceEpoch;
    final rand = random.nextInt(99999);
    return '$millis$rand';
  }

  void _addImageToMyStatus() {
    Story myStatus = Story(
      id: generateId(),
      mediaUrl: _capturedImagePath!,
      mediaType: MediaType.image,
      createdAt: DateTime.now(),
      duration: Duration(seconds: 20),
    );

    User.storyUser[0].stories.add(myStatus);
    print(_capturedImagePath!);

    widget.pageController.animateToPage(
      1,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _addVideoToMyStatus() {
    Story myStatus = Story(
      id: generateId(),
      mediaUrl: _recordedVideoPath!,
      mediaType: MediaType.video,
      createdAt: DateTime.now(),
    );

    User.storyUser[0].stories.add(myStatus);
    widget.pageController.animateToPage(
      1,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _playPauseVideo() {
    if (_videoPlayerController == null ||
        !_videoPlayerController!.value.isInitialized) {
      return;
    }

    try {
      setState(() {
        if (_videoPlayerController!.value.isPlaying) {
          _videoPlayerController!.pause();
          _isPlayingVideo = false;
        } else {
          _videoPlayerController!.play();
          _isPlayingVideo = true;
        }
      });
    } catch (e) {
      print('Error playing/pausing video: $e');
      setState(() {
        _videoError = 'Playback control error: $e';
      });
    }
  }

  void _clearCapture() {
    setState(() {
      _capturedImagePath = null;
      _recordedVideoPath = null;
      _isPlayingVideo = false;
      _videoError = null;
    });

    _disposeVideoPlayer();
  }

  String _formatRecordingTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _disposeVideoPlayer();
    _recordingController.dispose();
    _scaleController.dispose();
    _recordingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screendim = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera preview or captured media
          if (_capturedImagePath != null)
            SizedBox(
              height: screendim.height * 0.8,
              child: _buildImagePreview(screendim),
            )
          else if (_recordedVideoPath != null)
            SizedBox(
              height: screendim.height * 0.8,
              child: _buildVideoPreview(screendim),
            )
          else if (_isCameraInitialized && _cameraController != null)
            SizedBox(
              height: screendim.height * 0.8,
              child: _buildCameraPreview(screendim),
            )
          else
            _buildLoadingPreview(screendim),

          if (_videoError != null)
            Positioned(
              top: MediaQuery.of(context).padding.top + 100,
              left: 20,
              right: 20,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _videoError!,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: const FaIcon(
                            FontAwesomeIcons.xmark,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: _toggleFlash,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(child: _getFlashIcon()),
                      ),
                    ),

                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: const FaIcon(
                          FontAwesomeIcons.gear,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),
                if (_isRecording)
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        _formatRecordingTime(_recordingSeconds),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                Spacer(),

                Column(
                  children: [
                    if (_recordedVideoPath != null &&
                        _videoPlayerController != null &&
                        _videoPlayerController!.value.isInitialized)
                      Center(
                        child: Container(
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Material(
                            color: Colors.transparent,
                            shape: CircleBorder(),
                            child: InkWell(
                              customBorder: CircleBorder(),
                              onTap: _playPauseVideo,
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Center(
                                  child: FaIcon(
                                    _isPlayingVideo
                                        ? FontAwesomeIcons.pause
                                        : FontAwesomeIcons.play,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (_capturedImagePath != null ||
                            _recordedVideoPath != null)
                          Center(
                            child: ElevatedButton(
                              onPressed: _clearCapture,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    24,
                                  ),
                                ),
                              ),
                              child: SizedBox(
                                height: 60,

                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.chevronLeft,
                                      size: 24,
                                      color: AppTheme.black,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Discard',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(color: AppTheme.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                        if (_capturedImagePath != null ||
                            _recordedVideoPath != null)
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_capturedImagePath != null) {
                                  _addImageToMyStatus();
                                } else {
                                  _addVideoToMyStatus();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    24,
                                  ),
                                ),
                              ),
                              child: SizedBox(
                                height: 60,

                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'share',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(color: AppTheme.black),
                                    ),
                                    SizedBox(width: 10),
                                    FaIcon(
                                      FontAwesomeIcons.chevronRight,
                                      size: 24,
                                      color: AppTheme.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),

                if (_capturedImagePath == null && _recordedVideoPath == null)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,

                        children: [
                          _isRecording
                              ? SizedBox(width: 40)
                              : Material(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  color: Colors.transparent,
                                  child: InkWell(
                                    customBorder: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    onTap: () {
                                      _pickImageFromGallery();
                                    },
                                    child: SizedBox(
                                      height: 55,
                                      width: 55,
                                      child: Center(
                                        child: const FaIcon(
                                          FontAwesomeIcons.solidImage,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                          Center(
                            child: GestureDetector(
                              onTap: _takePicture,
                              onLongPressStart: (_) => _startRecording(),
                              onLongPressEnd: (_) => _stopRecording(),
                              child: AnimatedBuilder(
                                animation: Listenable.merge([
                                  _recordingController,
                                  _scaleController,
                                ]),
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
                                          color: _isRecording
                                              ? Colors.transparent
                                              : Colors.white,
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          if (_isRecording)
                                            CustomPaint(
                                              size: const Size(100, 100),
                                              painter:
                                                  GradientCircularProgressPainter(
                                                    progress:
                                                        _recordingController
                                                            .value,
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
                            ),
                          ),

                          _buildToolItem(FontAwesomeIcons.layerGroup, 'Layout'),
                        ],
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCameraPreview(Size screendim) {
    if (_cameraController == null) return const SizedBox.shrink();
    if (!_cameraController!.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      width: double.infinity,
      height: screendim.height * 0.8,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
      clipBehavior: Clip.antiAlias,
      child: CameraPreview(_cameraController!),
    );
  }

  Widget _buildImagePreview(Size screendim) {
    return Container(
      width: double.infinity,
      height: screendim.height * 0.8,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.black,
        image: DecorationImage(
          image: FileImage(File(_capturedImagePath!)),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildVideoPreview(Size screendim) {
    if (_videoPlayerInitializing) {
      return Container(
        width: double.infinity,
        height: screendim.height * 0.8,
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.black,
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.white),
              SizedBox(height: 16),
              Text('Loading video...', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      );
    }

    if (_videoPlayerController == null ||
        !_videoPlayerController!.value.isInitialized) {
      return Container(
        width: double.infinity,
        height: screendim.height * 0.8,
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.black,
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: screendim.height * 0.8,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.black,
      ),
      clipBehavior: Clip.antiAlias,
      child: AspectRatio(
        aspectRatio: _videoPlayerController!.value.aspectRatio,
        child: VideoPlayer(_videoPlayerController!),
      ),
    );
  }

  Widget _buildLoadingPreview(Size screendim) {
    return Container(
      width: double.infinity,
      height: screendim.height * 0.8,
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.black,
      ),
      child: const Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }

  Widget _buildToolItem(IconData icon, String label) {
    return Material(
      color: Colors.transparent,
      shape: CircleBorder(),
      child: InkWell(
        customBorder: CircleBorder(),
        onTap: () {},
        child: SizedBox(
          height: 70,
          width: 70,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 28),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
