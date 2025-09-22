import 'package:chatbox/features/friend/domain/entity/friend_request_entity.dart';

import '../model/friend_request_list_response.dart';

extension FriendRequestMapper on FriendRequest{
  FriendRequestEntity get toEntity=>FriendRequestEntity(
    profilePic: profilePic.secureUrl,
    bio: bio,
    username: username,
  );

}