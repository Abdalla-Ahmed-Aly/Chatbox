import 'package:chatbox/core/failure/failure.dart';
import 'package:chatbox/features/auth/data/model/register_request.dart';
import 'package:chatbox/features/auth/data/model/send_verification_request.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure,String>>register(RegisterRequest request);
  Future<Either<Failure,String>>verification(SendVerificationRequest request);

}