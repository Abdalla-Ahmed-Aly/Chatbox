import '../../domain/entity/friend_entity.dart';
import '../model/friends_response.dart';
extension FriendsMapper on Friend{
FriendEntity get toEntity=>FriendEntity(
    username: username,
    bio: bio,
    firstLetter: firstLetter,
    profilePic: profilePic.secureUrl,
    status: status
);


}