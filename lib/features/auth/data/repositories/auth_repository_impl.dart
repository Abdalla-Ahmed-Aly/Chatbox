import 'package:chatbox/core/error/exceptions.dart';
import 'package:chatbox/core/failure/failure.dart';
import 'package:chatbox/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:chatbox/features/auth/data/model/register_request.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/auth_repository.dart';
@Singleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

 const AuthRepositoryImpl(this._remoteDataSource);
  @override
  Future<Either<Failure, String>> register(RegisterRequest request) async {
    try {
      final response = await _remoteDataSource.register(request);
      return Right(response.message);
    }
    on AppException catch (exception) {
      return Left(Failure(exception.message));
    }
  }
}