
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/constants/api_constant/api_constant.dart';
import '../../../../../core/error/exceptions.dart';
import '../../model/friends_response.dart';
import 'friend_remote_data_source.dart';

@LazySingleton(as:FriendRemoteDataSource)
class FriendApiDataSource implements FriendRemoteDataSource {
  final Dio _dio;
  FriendApiDataSource(this._dio);
  @override
  Future<FriendsResponse> fetchFriends() async{

    try {
      final response = await _dio.get(APIConstant.fetchFriendsEndpoint);
      return FriendsResponse.fromJson(response.data);

    }
    catch(error){

      String? message;
      if(error is DioException){
        message = error.response?.data['message'];
      }
     throw RemoteException(message??"An error occurred while showing friends.");
    }

  }

}