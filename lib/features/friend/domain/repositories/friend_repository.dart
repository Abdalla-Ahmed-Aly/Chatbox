import 'package:chatbox/core/failure/failure.dart';
import 'package:chatbox/features/friend/domain/entity/friend_entity.dart';
import 'package:dartz/dartz.dart';

abstract class FriendRepository {
  Future<Either<Failure,List<FriendEntity>>>fetchFriends();



}