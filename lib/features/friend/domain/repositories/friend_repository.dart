import 'package:chatbox/core/failure/failure.dart';
import 'package:chatbox/core/model/shared_request.dart';
import 'package:chatbox/features/friend/domain/entity/friend_entity.dart';
import 'package:chatbox/features/friend/domain/entity/friend_request_entity.dart';
import 'package:dartz/dartz.dart';

import '../../data/model/handel_friend_request_model.dart';

abstract class FriendRepository {
  Future<Either<Failure,List<FriendEntity>>>fetchFriends();
  Future<Either<Failure,String>>addFriend (SharedRequest request);
  Future<Either<Failure,String>>removeFriend (SharedRequest request);
  Future<Either<Failure,List<FriendRequestEntity>>>getFriendsRequestList();
  Future<Either<Failure,String>>handelFriendRequest (HandelFriendRequestModel request);



}