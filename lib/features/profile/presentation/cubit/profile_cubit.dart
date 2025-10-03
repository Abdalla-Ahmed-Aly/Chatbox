import 'package:chatbox/features/profile/domain/entity/user_entity.dart';
import 'package:chatbox/features/profile/domain/repositories/user_repositories.dart';
import 'package:chatbox/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository profileRepository;
  String? _cachedUserId;

  ProfileCubit({required this.profileRepository}) : super(ProfileInitial());
  String? get currentUserId => _cachedUserId;

  Future<UserEntity> getUserProfile() async {
    // emit(ProfileLoading());

    final result = await profileRepository.getUserProfile();

    return result.fold(
      (error) {
        emit(ProfileFailure(error.message));
        throw Exception(error.message);
      },
      (response) {
        _cachedUserId = response.id;
        emit(ProfileSuccess(response));
        return response;
      },
    );
  }
}
