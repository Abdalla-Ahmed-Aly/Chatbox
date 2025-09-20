import 'package:chatbox/core/model/shared_response.dart';
import 'package:chatbox/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/failure/failure.dart';
import '../../data/model/otp_request.dart';


@injectable
class Otp {
  final AuthRepository _authRepository;
  Otp(this._authRepository);
  Future<Either<Failure,SharedResponse>>call(OtpRequest request)=>_authRepository.confirmOtp(request);



}