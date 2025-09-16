import 'package:chatbox/core/failure/failure.dart';
import 'package:chatbox/features/profile/domain/entity/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getUserProfile();
}
