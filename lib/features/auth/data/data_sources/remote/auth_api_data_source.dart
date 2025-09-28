import 'package:chatbox/core/constants/api_constant/api_constant.dart';
import 'package:chatbox/features/auth/data/model/login_request.dart';
import 'package:chatbox/features/auth/data/model/login_response.dart';
import 'package:chatbox/features/auth/data/model/otp_request.dart';
import 'package:chatbox/features/auth/data/model/register_request.dart';
import 'package:chatbox/features/auth/data/model/register_response.dart';
import 'package:chatbox/features/auth/data/model/reset_password_request.dart';
import 'package:chatbox/core/model/shared_response.dart';
import 'package:chatbox/features/auth/data/model/send_verification_request.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error/exceptions.dart';
import 'auth_remote_data_source.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthApiDataSource implements AuthRemoteDataSource {
  final Dio _dio;
  AuthApiDataSource(this._dio);
  @override
  Future<RegisterResponse> register(RegisterRequest request) async {
    try {
      final response = await _dio.post(
        APIConstant.registerEndpoint,
        data: request.toJson(),
      );
      return RegisterResponse.fromJson(response.data);
    } catch (exception) {
      String? message;
      if (exception is DioException) {
        message = exception.response?.data["message"];
      }
      throw RemoteException(message ?? "An error occurred while registering.");
    }
  }

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _dio.post(
        APIConstant.loginEndpoint,
        data: request.toJson(),
      );

      return LoginResponse.fromJson(response.data);
    } catch (exception) {
      String? message;
      if (exception is DioException) {
        message = exception.response?.data["message"];
      }
      throw RemoteException(message ?? "An error occurred while registering.");
    }
  }

  @override
  Future<SharedResponse> sendVerification(
    SendVerificationRequest request,
  ) async {
    try {
      final response = await _dio.post(
        APIConstant.vericationEndpoint,
        data: request.toJson(),
      );
      return SharedResponse.fromJson(response.data);
    } catch (error) {
      String? message;
      if (error is DioException) {
        message = error.response?.data["message"];
      }
      throw RemoteException(
        message ?? "An error occurred while sending verification code.",
      );
    }
  }

  @override
  Future<SharedResponse> confirmOtp(OtpRequest request) async {
    try {
      final response = await _dio.post(
        APIConstant.confirmOtpEndpoint,
        data: request.toJson(),
      );
      return SharedResponse.fromJson(response.data);
    } catch (error) {
      String? message;
      if (error is DioException) {
        message = error.response?.data["message"];
      }
      throw RemoteException(
        message ?? "An error occurred while confirming OTP.",
      );
    }
  }

  @override
  Future<SharedResponse> resetPassword(ResetPasswordRequest request) async {
    try {
      final response = await _dio.post(
        APIConstant.resetPasswordEndpoint,
        data: request.toJson(),
      );
      return SharedResponse.fromJson(response.data);
    } catch (error) {
      String? message;
      if (error is DioException) {
        message = error.response?.data["message"];
      }
      throw RemoteException(
        message ?? "An error occurred while reset password.",
      );
    }
  }
}
