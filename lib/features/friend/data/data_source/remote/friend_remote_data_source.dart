import 'package:chatbox/features/friend/data/model/friends_response.dart';

abstract class FriendRemoteDataSource {
  Future<FriendsResponse>fetchFriends();



}