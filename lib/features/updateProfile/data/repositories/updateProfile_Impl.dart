import 'package:chatbox/core/error/exceptions.dart';
import 'package:chatbox/core/failure/failure.dart';
import 'package:chatbox/features/updateProfile/data/data_sources/remote/updateProfile_remote_data_sources.dart';
import 'package:chatbox/features/updateProfile/data/mappers/update_mapper.dart';
import 'package:chatbox/features/updateProfile/data/model/update_profile_request.dart';
import 'package:chatbox/features/updateProfile/domain/entity/update_profile_Entity.dart';
import 'package:chatbox/features/updateProfile/domain/repositories/updateProfile_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UpdateProfileRepository)
class UpdateprofileImpl extends UpdateProfileRepository {
  UpdateprofileRemoteDataSources _remoteDataSources;
  UpdateprofileImpl(this._remoteDataSources);
  @override
  Future<Either<Failure, UpdateProfileEntity>> updateProfile(
    UpdateProfileRequest request,
  ) async {
    try {
      final response = await _remoteDataSources.updateProfile(request);
      return Right(response.toEntity());
    } on AppException catch (exception) {
      return Left(Failure(exception.message.toString()));
    }
  }
}
