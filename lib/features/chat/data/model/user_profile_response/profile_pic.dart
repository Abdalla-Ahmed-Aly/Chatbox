import 'package:chatbox/features/updateProfile/data/model/photo_response/profile_pic.dart';

class ProfilePicResponse {
  final String secureUrl;
  final String publicId;

  ProfilePicResponse({
    required this.secureUrl,
    required this.publicId,
  });

  factory ProfilePicResponse.fromJson(Map<String, dynamic> json) {
    return ProfilePicResponse(
      secureUrl: json['secure_url'],
      publicId: json['public_id'],
    );
  }

  ProfilePic toEntity() {
    return ProfilePic(
      secureUrl: secureUrl,
       publicId: publicId,
    );
  }
}