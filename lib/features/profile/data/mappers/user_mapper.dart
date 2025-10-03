import 'package:chatbox/features/profile/data/model/user_response.dart';
import 'package:chatbox/features/profile/domain/entity/sup_entity/photo.dart';
import 'package:chatbox/features/profile/domain/entity/user_entity.dart';

extension UserResponseMapper on UserResponse {
  UserEntity toEntity() {
    final user = results?.user;

    return UserEntity(
      username: user?.username ?? '',
      email: user?.email ?? '',
      phoneNumber: user?.phoneNumber ?? '',
      bio: user?.bio ?? '',
      address: user?.address ?? '',
      id: user?.id ?? '',
      profilePicture: user?.profilePicture != null
          ? ProfilePictureEntity(
              secureUrl: user!.profilePicture.secureUrl ?? '',
              publicId: user.profilePicture.publicId ?? '',
            )
          : const ProfilePictureEntity(secureUrl: '', publicId: ''),
    );
  }
}
