import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/model/shared_request.dart';
import '../repositories/friend_repository.dart';

@lazySingleton
class AddFriendUseCase {
  final FriendRepository _repo;

  AddFriendUseCase(this._repo);
  Future<Either<Failure,String>>call (SharedRequest request)=>_repo.addFriend(request);

}