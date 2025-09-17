import 'package:chatbox/core/failure/failure.dart';
import 'package:chatbox/features/updateProfile/data/model/update_profile_request.dart';
import 'package:chatbox/features/updateProfile/domain/entity/update_profile_Entity.dart';
import 'package:chatbox/features/updateProfile/domain/repositories/updateProfile_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class Updateprofile {
  UpdateProfileRepository repository;
  Updateprofile(this.repository);
  Future<Either<Failure, UpdateProfileEntity>> call(    UpdateProfileRequest request,
) {
    return repository.updateProfile(request);
  }
}
