import 'package:chatbox/core/failure/failure.dart';
import 'package:chatbox/features/auth/data/model/register_request.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure,String>>register(RegisterRequest request);

}