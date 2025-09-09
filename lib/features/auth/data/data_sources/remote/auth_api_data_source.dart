import 'package:chatbox/core/constants/api_constant/api_constant.dart';
import 'package:chatbox/features/auth/data/model/register_request.dart';

import 'package:chatbox/features/auth/data/model/register_response.dart';
import 'package:chatbox/features/auth/data/model/send_verification_request.dart';
import 'package:chatbox/features/auth/data/model/receive_verification_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error/exceptions.dart';
import 'auth_remote_data_source.dart';
@Singleton(as: AuthRemoteDataSource)
class AuthApiDataSource implements AuthRemoteDataSource{
 final Dio _dio;
  AuthApiDataSource(this._dio);
  @override
  Future<RegisterResponse> register(RegisterRequest request)async {
    try{
      final response=await _dio.post(
        APIConstant.registerEndpoint,
        data: request.toJson()
      );
      return RegisterResponse.fromJson(response.data);
    }catch(exception){
 String? message;
if(exception is DioException){
message=exception.response?.data["message"];
    }
throw RemoteException(message ?? "An error occurred while registering.");
    }


  }

  @override
  Future<ReceiveVerificationResponse> sendVerification(SendVerificationRequest request) async{
    try {
      final response = await _dio.post(
          APIConstant.vericationEndpoint,
          data: request.toJson()
      );
      return ReceiveVerificationResponse.fromJson(response.data);
    }catch(error){
      String?message;
      if(error is DioException){
        message=error.response?.data["message"];
      }
      throw RemoteException(message ?? "An error occurred while sending verification code.");


    }
  }


}