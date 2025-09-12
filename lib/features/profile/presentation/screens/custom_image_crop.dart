import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:chatbox/core/theme/app_theme.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CustomImageCropScreen extends StatefulWidget {
  final File cameraImage;
  final Function(File?) onCropped;

  const CustomImageCropScreen({
    super.key,
    required this.cameraImage,
    required this.onCropped,
  });

  @override
  State<CustomImageCropScreen> createState() => _CustomImageCropScreenState();
}

class _CustomImageCropScreenState extends State<CustomImageCropScreen> {
  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();

  Future<File?> _cropImage() async {
    final state = editorKey.currentState;
    if (state == null) return null;

    final rect = state.getCropRect();
    final uiImage = await state.image;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    canvas.drawImageRect(
      uiImage!,
      rect!,
      Rect.fromLTWH(0, 0, rect.width, rect.height),
      Paint(),
    );
    final picture = recorder.endRecording();

    final croppedUiImage = await picture.toImage(
      rect.width.toInt(),
      rect.height.toInt(),
    );
    final byteData = await croppedUiImage.toByteData(
      format: ui.ImageByteFormat.png,
    );
    final buffer = byteData!.buffer.asUint8List();

    final directory = await getApplicationDocumentsDirectory();
    final fileName =
        'profile_image_${DateTime.now().millisecondsSinceEpoch}.png';
    final tempFile = File('${directory.path}/$fileName');
    await tempFile.writeAsBytes(buffer);

    return tempFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: ExtendedImage.file(
              widget.cameraImage,
              fit: BoxFit.contain,
              mode: ExtendedImageMode.editor,
              extendedImageEditorKey: editorKey,
              initEditorConfigHandler: (state) {
                return EditorConfig(
                  maxScale: 8.0,
                  cropRectPadding: const EdgeInsets.all(20.0),
                  cornerColor: AppTheme.primary,
                  cornerSize: Size(20, 3),
                  lineColor: AppTheme.primary,
                  hitTestSize: 20.0,
                  cropAspectRatio: 1.0,
                  initCropRectType: InitCropRectType.imageRect,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final croppedFile = await _cropImage();
                    if (croppedFile != null) {
                      widget.onCropped(croppedFile);
                      Navigator.pop(context, croppedFile);
                    }
                  },
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
