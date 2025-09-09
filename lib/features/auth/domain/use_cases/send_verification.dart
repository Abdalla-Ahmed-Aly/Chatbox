import 'package:chatbox/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failure/failure.dart';
import '../../data/model/send_verification_request.dart';

@lazySingleton
class SendVerification {
 final AuthRepository _authRepository;
  SendVerification(this._authRepository);
  Future<Either<Failure, String>> call(SendVerificationRequest request)async=>_authRepository.verification(request);
}