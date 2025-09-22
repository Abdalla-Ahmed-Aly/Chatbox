import 'package:chatbox/core/model/shared_response.dart';
import 'package:chatbox/features/friend/data/model/friends_response.dart';
import 'package:chatbox/features/friend/data/model/remove_friend_response.dart';
import '../../../../../core/model/shared_request.dart';

abstract class FriendRemoteDataSource {
  Future<FriendsResponse>fetchFriends();
  Future<RemoveFriendResponse>removeFriend(SharedRequest request);
//  Future<SearchUserResponse>searchUser(String username);
    Future<SharedResponse>addFriend(SharedRequest request);



}