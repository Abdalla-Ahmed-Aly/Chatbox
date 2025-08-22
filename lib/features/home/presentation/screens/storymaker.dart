import 'package:camera/camera.dart';
import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/features/home/presentation/widgets/slashed_lightning.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StoryMaker extends StatefulWidget {
  const StoryMaker({super.key});
  static final String routeName = '/storymaker';

  @override
  State<StoryMaker> createState() => _StoryMakerState();
}

class _StoryMakerState extends State<StoryMaker> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras = [];
  final bool _isRecording = false;
  bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras![0], ResolutionPreset.high);
    await _cameraController!.initialize();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: Stack(
          children: [
            _cameraController != null && _cameraController!.value.isInitialized
                ? CameraPreview(_cameraController!)
                : Container(
                    color: Colors.black,
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
            Column(children: [_buildHeaderTools()]),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderTools() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: FaIcon(
              FontAwesomeIcons.xmark,
              size: 30,
              color: AppTheme.primary,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _isFlashOn = !_isFlashOn;
              });
            },
            icon: _isFlashOn
                ? FaIcon(
                    FontAwesomeIcons.bolt,
                    size: 30,
                    color: AppTheme.primary,
                  )
                : SlashedLightning(),
          ),
          IconButton(
            onPressed: () {},
            icon: FaIcon(
              FontAwesomeIcons.gear,
              size: 30,
              color: AppTheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
