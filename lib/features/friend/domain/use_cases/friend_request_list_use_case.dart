import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failure/failure.dart';
import '../entity/friend_request_entity.dart';
import '../repositories/friend_repository.dart';

@lazySingleton
class FriendRequestListUseCase {
  final FriendRepository _repo;
 const FriendRequestListUseCase(this._repo);

  Future<Either<Failure,List<FriendRequestEntity>>>call()=>_repo.getFriendsRequestList();


}