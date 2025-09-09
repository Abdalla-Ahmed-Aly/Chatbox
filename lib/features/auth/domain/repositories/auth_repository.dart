import 'package:chatbox/core/failure/failure.dart';
import 'package:chatbox/features/auth/data/model/otp_request.dart';
import 'package:chatbox/features/auth/data/model/otp_response.dart';
import 'package:chatbox/features/auth/data/model/register_request.dart';
import 'package:chatbox/features/auth/data/model/reset_password_response.dart';
import 'package:chatbox/features/auth/data/model/send_verification_request.dart';
import 'package:dartz/dartz.dart';

import '../../data/model/reset_password_request.dart';

abstract class AuthRepository {
  Future<Either<Failure,String>>register(RegisterRequest request);
  Future<Either<Failure,String>>verification(SendVerificationRequest request);
  Future<Either<Failure,OtpResponse>>confirmOtp(OtpRequest request);
  Future<Either<Failure,ResetPasswordResponse>>resetPassword(ResetPasswordRequest request);

}