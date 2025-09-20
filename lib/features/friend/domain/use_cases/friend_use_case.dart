import 'package:chatbox/features/friend/domain/repositories/friend_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failure/failure.dart';
import '../entity/friend_entity.dart';
@injectable
class FriendUseCase {
  final FriendRepository _repo;
 const FriendUseCase(this._repo);
  Future<Either<Failure, List<FriendEntity>>> call()=>_repo.fetchFriends();




}