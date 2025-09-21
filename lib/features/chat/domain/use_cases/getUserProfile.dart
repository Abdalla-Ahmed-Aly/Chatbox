import 'package:chatbox/core/failure/failure.dart';
import 'package:chatbox/features/chat/domain/entity/user_profile_entity.dart';
import 'package:chatbox/features/chat/domain/repositories/user_profile_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetUserProfile {
  final UserProfileRepository repository;
  GetUserProfile(this.repository);

  Future<Either<Failure, UserProfileEntity>> call(Params params) {
    return repository.getUserProfile(params);
  }
}

class Params {
  final String username;
  Params(this.username);
}
