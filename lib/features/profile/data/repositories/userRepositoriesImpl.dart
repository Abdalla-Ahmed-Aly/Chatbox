import 'package:chatbox/core/error/exceptions.dart';
import 'package:chatbox/core/failure/failure.dart';
import 'package:chatbox/features/profile/data/data_sources/remote/user_remote_data_source.dart';
import 'package:chatbox/features/profile/data/mappers/user_mapper.dart';
import 'package:chatbox/features/profile/domain/entity/user_entity.dart';
import 'package:chatbox/features/profile/domain/repositories/user_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepository)
class Userrepositoriesimpl extends UserRepository {
  UserRemoteDataSource _remoteDataSource;
  Userrepositoriesimpl(this._remoteDataSource);
  @override
  Future<Either<Failure, UserEntity>> getUserProfile() async {
    try {
      final response = await _remoteDataSource.getUserProfile();
      return Right(response.toEntity());
    } on AppException catch (exception) {
      return Left(Failure(exception.message.toString()));
    }
  }
}
