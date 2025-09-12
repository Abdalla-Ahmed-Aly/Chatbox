import 'package:chatbox/features/auth/data/model/otp_request.dart';
import 'package:chatbox/features/auth/data/model/register_request.dart';
import 'package:chatbox/features/auth/data/model/register_response.dart';
import 'package:chatbox/features/auth/data/model/reset_password_request.dart';
import 'package:chatbox/features/auth/data/model/shared_response.dart';
import '../../model/send_verification_request.dart';


abstract class AuthRemoteDataSource {
  Future<RegisterResponse>register(RegisterRequest request);
  Future<SharedResponse>sendVerification(SendVerificationRequest request);
  Future<SharedResponse>confirmOtp(OtpRequest request);
  Future<SharedResponse>resetPassword(ResetPasswordRequest request);


}