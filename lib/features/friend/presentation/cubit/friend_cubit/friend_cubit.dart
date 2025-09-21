import 'package:chatbox/features/friend/domain/use_cases/friend_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'friend_stats.dart';
@lazySingleton
class FriendCubit extends Cubit<FriendStats> {
  FriendCubit(this.friends) : super(FriendStatsInitial());
  final FriendUseCase friends;
  Future<void>fetchFriends()async{
    emit(FriendStatsLoading());
    final result=await friends();
    result.fold((error) =>emit(FriendStatsError(message: error.message)) , (friends) =>emit(FriendStatsSuccess( friends:friends)) ,);

  }

}
