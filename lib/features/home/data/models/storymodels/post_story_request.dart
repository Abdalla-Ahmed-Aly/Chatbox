import 'dart:io';
import 'package:dio/dio.dart';

class UploadStoryRequest {
  final File file;

  UploadStoryRequest({required this.file});

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'story': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      ),
    });
  }
}
