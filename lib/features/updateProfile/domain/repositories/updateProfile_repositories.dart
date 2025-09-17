import 'package:chatbox/core/failure/failure.dart';
import 'package:chatbox/features/updateProfile/data/model/update_profile_request.dart';
import 'package:chatbox/features/updateProfile/domain/entity/update_profile_Entity.dart';
import 'package:dartz/dartz.dart';

abstract class UpdateProfileRepository {
  Future<Either<Failure, UpdateProfileEntity>> updateProfile(UpdateProfileRequest request);
}
