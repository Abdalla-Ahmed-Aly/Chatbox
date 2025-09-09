import 'package:chatbox/features/auth/data/model/otp_request.dart';
import 'package:chatbox/features/auth/data/model/otp_response.dart';
import 'package:chatbox/features/auth/data/model/register_request.dart';
import 'package:chatbox/features/auth/data/model/register_response.dart';

import '../../model/send_verification_request.dart';
import '../../model/receive_verification_response.dart';

abstract class AuthRemoteDataSource {
  Future<RegisterResponse>register(RegisterRequest request);
  Future<ReceiveVerificationResponse>sendVerification(SendVerificationRequest request);
  Future<OtpResponse>confirmOtp(OtpRequest request);


}