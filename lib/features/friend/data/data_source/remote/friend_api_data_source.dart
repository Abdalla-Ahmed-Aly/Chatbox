import 'package:chatbox/core/model/shared_request.dart';
import 'package:chatbox/core/model/shared_response.dart';
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

  @override
  Future<SharedResponse> addFriend(SharedRequest request) async{
    try{
      final response = await _dio.post(APIConstant.addFriendEndpoint,data: request.toJson());
      return SharedResponse.fromJson(response.data);
    }catch(error){
      String? message;
      if(error is DioException){
        message=error.response?.data['message'];
      }
      throw RemoteException(message??"An error occurred while adding friend.");


    }
  }

  // @override
  // Future<SearchUserResponse> searchUser(String username)async {
  //  try{
  //    final response = await _dio.get(APIConstant.searchUserEndpoint,queryParameters: {'username':username});
  //    return SearchUserResponse.fromJson(response.data);
  //  }
  //  catch(error){
  //    String? message;
  //    if(error is DioException){
  //      message=error.response?.data['message'];
  //    }
  //    throw RemoteException(message??"An error occurred while searching user.");
  //
  //
  //
  //  }
  // }

}