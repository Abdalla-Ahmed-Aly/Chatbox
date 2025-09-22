import 'package:chatbox/features/profile/domain/entity/user_entity.dart';
import 'package:chatbox/features/profile/domain/repositories/user_repositories.dart';
import 'package:chatbox/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository profileRepository;

  ProfileCubit({required this.profileRepository}) : super(ProfileInitial());
  Future<UserEntity> getUserProfile() async {
    // emit(ProfileLoading());

    final result = await profileRepository.getUserProfile();

    return result.fold(
      (error) {
        emit(ProfileFailure(error.message));
        throw Exception(error.message);
      },
      (response) {
        emit(ProfileSuccess(response));
        return response;
      },
    );
  }
}
