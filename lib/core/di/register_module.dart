import 'package:chatbox/core/constants/api_constant/api_constant.dart';
import 'package:chatbox/features/auth/domain/storage/i_token_storage.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  @singleton
  Dio dio(ITokenStorage tokenStorage) {
    final dio = Dio(
      BaseOptions(
        baseUrl: APIConstant.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await tokenStorage.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (e, handler) {
          return handler.next(e);
        },
      ),
    );

    return dio;
  }
}
