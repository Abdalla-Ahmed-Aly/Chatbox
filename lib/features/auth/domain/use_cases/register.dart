import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failure/failure.dart';
import '../../data/model/register_request.dart';
import '../repositories/auth_repository.dart';
@injectable
class Register {
  const Register(this._authRepository);
  final AuthRepository _authRepository;
  Future<Either<Failure,String>>call(RegisterRequest request) =>_authRepository.register(request);
}