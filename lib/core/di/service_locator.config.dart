// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:chatbox/core/di/register_module.dart' as _i37;
import 'package:chatbox/features/auth/data/data_sources/remote/auth_api_data_source.dart'
    as _i719;
import 'package:chatbox/features/auth/data/data_sources/remote/auth_remote_data_source.dart'
    as _i817;
import 'package:chatbox/features/auth/data/repositories/auth_repository_impl.dart'
    as _i758;
import 'package:chatbox/features/auth/data/storage/token_storage.dart' as _i401;
import 'package:chatbox/features/auth/domain/repositories/auth_repository.dart'
    as _i493;
import 'package:chatbox/features/auth/domain/storage/i_token_storage.dart'
    as _i1033;
import 'package:chatbox/features/auth/domain/use_cases/login.dart' as _i71;
import 'package:chatbox/features/auth/domain/use_cases/otp.dart' as _i158;
import 'package:chatbox/features/auth/domain/use_cases/register.dart' as _i239;
import 'package:chatbox/features/auth/domain/use_cases/reset_password.dart'
    as _i1;
import 'package:chatbox/features/auth/domain/use_cases/send_verification.dart'
    as _i614;
import 'package:chatbox/features/auth/presentation/cubit/confirm_otp_cubit/confirm_otp_cubit.dart'
    as _i393;
import 'package:chatbox/features/auth/presentation/cubit/login/login_cubit.dart'
    as _i739;
import 'package:chatbox/features/auth/presentation/cubit/register_cubit/register_cubit.dart'
    as _i62;
import 'package:chatbox/features/auth/presentation/cubit/reset_password_cubit/reset_password_cubit.dart'
    as _i1010;
import 'package:chatbox/features/auth/presentation/cubit/send_verification_cubit/send_verification_cubit.dart'
    as _i1013;
import 'package:chatbox/features/chat/data/data_sources/remote/userProfile_api_data_source.dart'
    as _i406;
import 'package:chatbox/features/chat/data/data_sources/remote/userProfile_remote_data_source.dart'
    as _i709;
import 'package:chatbox/features/chat/data/repositories/getUserProfileImpl.dart'
    as _i377;
import 'package:chatbox/features/chat/domain/repositories/user_profile_repository.dart'
    as _i553;
import 'package:chatbox/features/chat/domain/use_cases/getUserProfile.dart'
    as _i438;
import 'package:chatbox/features/chat/presentation/cubit/get_user_profile_cubit.dart'
    as _i797;
import 'package:chatbox/features/friend/data/data_source/remote/friend_api_data_source.dart'
    as _i975;
import 'package:chatbox/features/friend/data/data_source/remote/friend_remote_data_source.dart'
    as _i310;
import 'package:chatbox/features/friend/data/repositories/friend_repository_impl.dart'
    as _i719;
import 'package:chatbox/features/friend/domain/repositories/friend_repository.dart'
    as _i385;
import 'package:chatbox/features/friend/domain/use_cases/add_friend_use_case.dart'
    as _i550;
import 'package:chatbox/features/friend/domain/use_cases/friend_use_case.dart'
    as _i208;
import 'package:chatbox/features/friend/domain/use_cases/remove_friend_use_case.dart'
    as _i105;
import 'package:chatbox/features/friend/presentation/cubit/add_friend_cubit/add_friend_cubit.dart'
    as _i923;
import 'package:chatbox/features/friend/presentation/cubit/friend_cubit/friend_cubit.dart'
    as _i1012;
import 'package:chatbox/features/friend/presentation/cubit/remove_friend_cubit/remove_friend_cubit.dart'
    as _i991;
import 'package:chatbox/features/profile/data/data_sources/remote/user_api_data_source.dart'
    as _i505;
import 'package:chatbox/features/profile/data/data_sources/remote/user_remote_data_source.dart'
    as _i582;
import 'package:chatbox/features/profile/data/repositories/userRepositoriesImpl.dart'
    as _i23;
import 'package:chatbox/features/profile/domain/repositories/user_repositories.dart'
    as _i673;
import 'package:chatbox/features/profile/domain/use_cases/Getuser.dart' as _i13;
import 'package:chatbox/features/profile/presentation/cubit/profile_cubit.dart'
    as _i133;
import 'package:chatbox/features/updateProfile/data/data_sources/remote/updateProfile_api_data_sources.dart'
    as _i972;
import 'package:chatbox/features/updateProfile/data/data_sources/remote/updateProfile_remote_data_sources.dart'
    as _i1049;
import 'package:chatbox/features/updateProfile/data/repositories/updateProfile_Impl.dart'
    as _i750;
import 'package:chatbox/features/updateProfile/domain/repositories/updateProfile_repositories.dart'
    as _i580;
import 'package:chatbox/features/updateProfile/domain/use_cases/updatePhoto.dart'
    as _i922;
import 'package:chatbox/features/updateProfile/domain/use_cases/updateProfile.dart'
    as _i208;
import 'package:chatbox/features/updateProfile/presentation/cubit/updateProfile_cubit.dart'
    as _i802;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i1033.ITokenStorage>(() => _i401.TokenStorage());
    gh.singleton<_i361.Dio>(
      () => registerModule.dio(gh<_i1033.ITokenStorage>()),
    );
    gh.lazySingleton<_i310.FriendRemoteDataSource>(
      () => _i975.FriendApiDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i385.FriendRepository>(
      () => _i719.FriendRepositoryImpl(gh<_i310.FriendRemoteDataSource>()),
    );
    gh.lazySingleton<_i709.UserprofileRemoteDataSource>(
      () => _i406.UserprofileApiDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i817.AuthRemoteDataSource>(
      () => _i719.AuthApiDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i1049.UpdateprofileRemoteDataSources>(
      () => _i972.UpdateprofileApiDataSources(dio: gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i493.AuthRepository>(
      () => _i758.AuthRepositoryImpl(
        gh<_i817.AuthRemoteDataSource>(),
        gh<_i1033.ITokenStorage>(),
      ),
    );
    gh.lazySingleton<_i553.UserProfileRepository>(
      () => _i377.Getuserprofileimpl(gh<_i709.UserprofileRemoteDataSource>()),
    );
    gh.lazySingleton<_i582.UserRemoteDataSource>(
      () => _i505.UserApiDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i550.AddFriendUseCase>(
      () => _i550.AddFriendUseCase(gh<_i385.FriendRepository>()),
    );
    gh.lazySingleton<_i208.FriendUseCase>(
      () => _i208.FriendUseCase(gh<_i385.FriendRepository>()),
    );
    gh.lazySingleton<_i105.RemoveFriendUseCase>(
      () => _i105.RemoveFriendUseCase(gh<_i385.FriendRepository>()),
    );
    gh.factory<_i923.AddFriendCubit>(
      () => _i923.AddFriendCubit(gh<_i550.AddFriendUseCase>()),
    );
    gh.singleton<_i797.GetUserProfileCubit>(
      () => _i797.GetUserProfileCubit(gh<_i553.UserProfileRepository>()),
    );
    gh.lazySingleton<_i580.UpdateProfileRepository>(
      () =>
          _i750.UpdateprofileImpl(gh<_i1049.UpdateprofileRemoteDataSources>()),
    );
    gh.lazySingleton<_i438.GetUserProfile>(
      () => _i438.GetUserProfile(gh<_i553.UserProfileRepository>()),
    );
    gh.lazySingleton<_i1012.FriendCubit>(
      () => _i1012.FriendCubit(gh<_i208.FriendUseCase>()),
    );
    gh.factory<_i802.UpdateprofileCubit>(
      () => _i802.UpdateprofileCubit(
        updateProfileRepository: gh<_i580.UpdateProfileRepository>(),
      ),
    );
    gh.lazySingleton<_i71.Login>(() => _i71.Login(gh<_i493.AuthRepository>()));
    gh.lazySingleton<_i158.Otp>(() => _i158.Otp(gh<_i493.AuthRepository>()));
    gh.lazySingleton<_i239.Register>(
      () => _i239.Register(gh<_i493.AuthRepository>()),
    );
    gh.lazySingleton<_i1.ResetPassword>(
      () => _i1.ResetPassword(gh<_i493.AuthRepository>()),
    );
    gh.lazySingleton<_i614.SendVerification>(
      () => _i614.SendVerification(gh<_i493.AuthRepository>()),
    );
    gh.factory<_i991.RemoveFriendCubit>(
      () => _i991.RemoveFriendCubit(gh<_i105.RemoveFriendUseCase>()),
    );
    gh.factory<_i62.RegisterCubit>(
      () =>
          _i62.RegisterCubit(gh<_i239.Register>(), gh<_i1033.ITokenStorage>()),
    );
    gh.factory<_i1010.ResetPasswordCubit>(
      () => _i1010.ResetPasswordCubit(gh<_i1.ResetPassword>()),
    );
    gh.factory<_i1013.SendVerificationCubit>(
      () => _i1013.SendVerificationCubit(gh<_i614.SendVerification>()),
    );
    gh.lazySingleton<_i922.Updatephoto>(
      () => _i922.Updatephoto(gh<_i580.UpdateProfileRepository>()),
    );
    gh.lazySingleton<_i208.Updateprofile>(
      () => _i208.Updateprofile(gh<_i580.UpdateProfileRepository>()),
    );
    gh.lazySingleton<_i673.UserRepository>(
      () => _i23.Userrepositoriesimpl(gh<_i582.UserRemoteDataSource>()),
    );
    gh.lazySingleton<_i13.Getuser>(
      () => _i13.Getuser(userRepository: gh<_i673.UserRepository>()),
    );
    gh.lazySingleton<_i133.ProfileCubit>(
      () => _i133.ProfileCubit(profileRepository: gh<_i673.UserRepository>()),
    );
    gh.factory<_i393.ConfirmOtpCubit>(
      () => _i393.ConfirmOtpCubit(gh<_i158.Otp>()),
    );
    gh.factory<_i739.LoginCubit>(
      () => _i739.LoginCubit(gh<_i71.Login>(), gh<_i1033.ITokenStorage>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i37.RegisterModule {}
