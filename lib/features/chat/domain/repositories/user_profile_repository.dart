import 'package:chatbox/core/failure/failure.dart';
import 'package:chatbox/features/chat/domain/entity/User_profile_entity.dart';
import 'package:chatbox/features/chat/domain/use_cases/getUserProfile.dart';
import 'package:dartz/dartz.dart';

abstract class UserProfileRepository {
  Future<Either<Failure, UserProfileEntity>> getUserProfile(Params params);
}
