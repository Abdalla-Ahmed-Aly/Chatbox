class UploadStoryResponse {
  final bool success;
  final String message;

  UploadStoryResponse({
    required this.success,
    required this.message,
  });

  factory UploadStoryResponse.fromJson(Map<String, dynamic> json) {
    return UploadStoryResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
    );
  }
}



