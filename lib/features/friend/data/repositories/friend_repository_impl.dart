
import 'package:chatbox/core/model/shared_request.dart';
import 'package:chatbox/features/friend/data/mappers/friends_mapper.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/failure/failure.dart';
import '../../domain/entity/friend_entity.dart';
import '../../domain/repositories/friend_repository.dart';
import '../data_source/remote/friend_remote_data_source.dart';

@LazySingleton(as:FriendRepository )
class FriendRepositoryImpl implements FriendRepository{
  final FriendRemoteDataSource _remoteDataSource;

 const FriendRepositoryImpl(this._remoteDataSource);
  @override
  Future<Either<Failure, List<FriendEntity>>> fetchFriends() async{
    try {
      final response = await _remoteDataSource.fetchFriends();
     final List<FriendEntity> friends= response.results.friends.map((friend)=>friend.toEntity).toList();
      return Right(friends);
    }
    on RemoteException catch(exception){
      return Left(Failure(exception.message));

    }
  }

  @override
  Future<Either<Failure, String>> addFriend(SharedRequest request) async{
    try{
      final response=await _remoteDataSource.addFriend(request);
      return Right(response.message);
    }
    on RemoteException catch(exception){
      return Left(Failure(exception.message));

    }
  }

  @override
  Future<Either<Failure, String>> removeFriend(SharedRequest request) async{
  try{
    final response=await _remoteDataSource.removeFriend(request);
    return Right(response.message);
  }on RemoteException catch(exception){
    return Left(Failure(exception.message));
  }
  }
}