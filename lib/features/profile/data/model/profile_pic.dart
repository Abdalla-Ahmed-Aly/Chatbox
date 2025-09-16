import 'package:chatbox/features/profile/domain/entity/sup_entity/photo.dart';

class ProfilePicture extends ProfilePictureEntity {
  ProfilePicture({
    required String secureUrl,
    required String publicId,
  }) : super(secureUrl: secureUrl, publicId: publicId);

  factory ProfilePicture.fromJson(Map<String, dynamic> json) {
    return ProfilePicture(
      secureUrl: json['secure_url'] ?? '',
      publicId: json['public_id'] ?? '',
    );
  }
}
