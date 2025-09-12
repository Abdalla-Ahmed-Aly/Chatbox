import 'package:chatbox/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../../data/model/reset_password_request.dart';
import '../../data/model/shared_response.dart';
@injectable
class ResetPassword {
  final AuthRepository _authRepository;

 const ResetPassword(this._authRepository);
  Future<Either<Failure,SharedResponse>>call(ResetPasswordRequest request)=>_authRepository.resetPassword(request);


}