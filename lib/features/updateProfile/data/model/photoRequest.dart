import 'dart:io';
import 'package:dio/dio.dart';

class PhotoRequest {
  final File image;

  PhotoRequest({required this.image});

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'image': await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      ),
    });
  }
}
