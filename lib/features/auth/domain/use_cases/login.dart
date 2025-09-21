import 'package:chatbox/features/auth/data/model/login_request.dart';
import 'package:chatbox/features/auth/data/model/login_response.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failure/failure.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class Login {
  const Login(this._authRepository);
  final AuthRepository _authRepository;
  Future<Either<Failure, LoginResponse>> call(LoginRequest request) {
    return _authRepository.login(request);
  }
}
