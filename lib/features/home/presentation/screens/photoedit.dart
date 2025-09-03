import 'dart:io';

import 'package:chatbox/features/home/presentation/widgets/image_gradient.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data';
import 'dart:ui' as ui;

class ImagePhotoViewCombo extends StatefulWidget {
  static final routename = 'imageView';
  final String imagePath;

  const ImagePhotoViewCombo({super.key, required this.imagePath});

  @override
  _ImagePhotoViewComboState createState() => _ImagePhotoViewComboState();
}

class _ImagePhotoViewComboState extends State<ImagePhotoViewCombo> {
  PhotoViewController? _controller;
  Uint8List? _processedImageBytes;
  bool _isProcessing = false;
  double _brightness = 0.0;
  double _contrast = 1.0;
  double _saturation = 1.0;
  TextEditingController? _textController;
  FocusNode? _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = PhotoViewController();
    _textController = TextEditingController();
    _focusNode = FocusNode();
    _loadAndProcessImage();
  }

  Future<void> _loadAndProcessImage() async {
    setState(() => _isProcessing = true);

    try {
      final ImageProvider imageProvider = FileImage(File(widget.imagePath));
      final imageStream = imageProvider.resolve(ImageConfiguration());

      imageStream.addListener(
        ImageStreamListener((ImageInfo imageInfo, bool synchronousCall) async {
          final byteData = await imageInfo.image.toByteData(
            format: ui.ImageByteFormat.png,
          );
          final originalBytes = byteData!.buffer.asUint8List();

          await _processImageWithAdjustments(originalBytes);
        }),
      );
    } catch (e) {
      print('Error loading image: $e');
      setState(() => _isProcessing = false);
    }
  }

  Future<void> _processImageWithAdjustments(Uint8List originalBytes) async {
    try {
      img.Image? image = img.decodeImage(originalBytes);

      if (image != null) {
        if (_brightness != 0.0) {
          image = img.adjustColor(image, brightness: _brightness);
        }

        if (_contrast != 1.0) {
          image = img.adjustColor(image, contrast: _contrast);
        }

        if (_saturation != 1.0) {
          image = img.adjustColor(image, saturation: _saturation);
        }

        _processedImageBytes = Uint8List.fromList(img.encodePng(image));

        setState(() => _isProcessing = false);
      }
    } catch (e) {
      setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screendim = MediaQuery.of(context).size;
    return Container(
      height: screendim.height * 0.8,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
      child: Stack(
        children: [
          GradientContainer(imageFile: File(widget.imagePath)),

          _isProcessing
              ? Center(child: CircularProgressIndicator())
              : PhotoView(
                  controller: _controller,
                  backgroundDecoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  imageProvider: _processedImageBytes != null
                      ? MemoryImage(_processedImageBytes!)
                      : AssetImage(widget.imagePath) as ImageProvider,
                  minScale: PhotoViewComputedScale.contained * 0.5,
                  maxScale: PhotoViewComputedScale.covered * 2.0,
                  initialScale: PhotoViewComputedScale.covered,
                  enableRotation: true,
                  enablePanAlways: true,
                  loadingBuilder: (context, event) => Center(
                    child: SizedBox(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(
                        value: event == null
                            ? 0
                            : event.cumulativeBytesLoaded /
                                  event.expectedTotalBytes!,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    _textController?.dispose();
    _focusNode?.dispose();
    super.dispose();
  }
}
