import 'package:chatbox/core/error/exceptions.dart';
import 'package:chatbox/core/failure/failure.dart';
import 'package:chatbox/features/chat/data/data_sources/remote/userProfile_remote_data_source.dart';
import 'package:chatbox/features/chat/data/mappers/get_user_profile_mapper.dart';
import 'package:chatbox/features/chat/domain/entity/user_profile_entity.dart';
import 'package:chatbox/features/chat/domain/repositories/user_profile_repository.dart';
import 'package:chatbox/features/chat/domain/use_cases/getUserProfile.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserProfileRepository)
class Getuserprofileimpl extends UserProfileRepository {
  final UserprofileRemoteDataSource _remoteDataSource;
  Getuserprofileimpl(this._remoteDataSource);
  @override
  Future<Either<Failure, UserProfileEntity>> getUserProfile(
    Params params,
  ) async {
    try {
      final response = await _remoteDataSource.getUserProfile(params);
      return Right(response.toEntity());
    } on AppException catch (exception) {
      return Left(Failure(exception.message.toString()));
    }
  }
}
