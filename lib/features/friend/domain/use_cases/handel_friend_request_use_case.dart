import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failure/failure.dart';
import '../../data/model/handel_friend_request_model.dart';
import '../repositories/friend_repository.dart';

@lazySingleton
class HandelFriendRequestUseCase {
  final FriendRepository _repo;

  HandelFriendRequestUseCase(this._repo);

  Future<Either<Failure,String>>call (HandelFriendRequestModel request)=>_repo.handelFriendRequest(request);

}