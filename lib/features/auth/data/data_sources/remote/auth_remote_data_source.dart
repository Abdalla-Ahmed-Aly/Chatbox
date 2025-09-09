import 'package:chatbox/features/auth/data/model/register_request.dart';
import 'package:chatbox/features/auth/data/model/register_response.dart';

abstract class AuthRemoteDataSource {
  Future<RegisterResponse>register(RegisterRequest request);


}