import 'package:chatbox/core/error/exceptions.dart';
import 'package:chatbox/core/failure/failure.dart';
import 'package:chatbox/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:chatbox/features/auth/data/model/login_request.dart';
import 'package:chatbox/features/auth/data/model/login_response.dart';
import 'package:chatbox/features/auth/data/model/otp_request.dart';
import 'package:chatbox/features/auth/data/model/register_request.dart';
import 'package:chatbox/features/auth/data/model/register_response.dart';
import 'package:chatbox/features/auth/data/model/reset_password_request.dart';
import 'package:chatbox/features/auth/data/model/shared_response.dart';
import 'package:chatbox/features/auth/data/model/send_verification_request.dart';
import 'package:chatbox/features/auth/domain/storage/i_token_storage.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final ITokenStorage _localDataSource;
  const AuthRepositoryImpl(this._remoteDataSource, this._localDataSource);
  @override
  Future<Either<Failure, RegisterResponse>> register(RegisterRequest request) async {
    try {
      final response = await _remoteDataSource.register(request);
      await _localDataSource.saveToken(response.token);

      return Right(response);
    } on AppException catch (exception) {
      return Left(Failure(exception.message));
    }
  }

  @override
  Future<Either<Failure, LoginResponse>> login(LoginRequest request) async {
    try {
      final response = await _remoteDataSource.Login(request);

      await _localDataSource.saveToken(response.token);

      return Right(response);
    } on AppException catch (exception) {
      return Left(Failure(exception.message));
    }
  }

  @override
  Future<Either<Failure, String>> verification(
    SendVerificationRequest request,
  ) async {
    try {
      final response = await _remoteDataSource.sendVerification(request);
      return Right(response.message);
    } on AppException catch (exception) {
      return Left(Failure(exception.message));
    }
  }

  @override
  Future<Either<Failure, SharedResponse>> confirmOtp(OtpRequest request) async {
    try {
      final response = await _remoteDataSource.confirmOtp(request);
      return Right(response);
    } on AppException catch (exception) {
      return Left(Failure(exception.message));
    }
  }

  @override
  Future<Either<Failure, SharedResponse>> resetPassword(
    ResetPasswordRequest request,
  ) async {
    try {
      final response = await _remoteDataSource.resetPassword(request);
      return Right(response);
    } on AppException catch (exception) {
      return Left(Failure(exception.message));
    }
  }
}
