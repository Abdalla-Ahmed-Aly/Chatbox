import 'package:chatbox/core/constants/api_constant/api_constant.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
@singleton
Dio get dio => Dio(BaseOptions(baseUrl: APIConstant.baseUrl, receiveDataWhenStatusError: true));


}