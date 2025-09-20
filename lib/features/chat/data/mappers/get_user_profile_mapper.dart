import 'package:chatbox/features/chat/data/model/user_profile_response/user_profile_response.dart';
import 'package:chatbox/features/chat/domain/entity/user_profile_entity.dart';
import 'package:chatbox/features/profile/data/model/profile_pic.dart';

extension GetUserProfileMapper on UserProfileResponse {
  UserProfileEntity toEntity() {
    final user = results?.user;

    return UserProfileEntity(
      username: user?.username ?? '',
      email: user?.email ?? '',
      phoneNumber: user?.phoneNumber ?? '',
      bio: user?.bio ?? '',
      status: user?.status ?? '',
      address: user?.address ?? '',
      profilePicture: user?.profilePic != null
          ? ProfilePicture(
              secureUrl: user!.profilePic!.secureUrl ?? '',
              publicId: user!.profilePic!.publicId ?? '',
            )
          : ProfilePicture(secureUrl: '', publicId: ''),
    );
  }
}
