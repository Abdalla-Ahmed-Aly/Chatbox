import 'package:chatbox/features/updateProfile/data/model/update_profile_response.dart';
import 'package:chatbox/features/updateProfile/domain/entity/update_profile_Entity.dart';

extension updateProfileMapper on UpdateProfileResponse {
  UpdateProfileEntity toEntity() {
    final user = results?.user;
    return UpdateProfileEntity(
      username: user?.username ?? '',
      phoneNumber: user?.phoneNumber ?? '',
      address: user?.address ?? '',
      bio: user?.bio ?? '',
      message: message ?? '',
    );
  }
}
