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
import 'package:chatbox/features/auth/domain/repositories/auth_repository.dart'
    as _i493;
import 'package:chatbox/features/auth/domain/use_cases/otp.dart' as _i158;
import 'package:chatbox/features/auth/domain/use_cases/register.dart' as _i239;
import 'package:chatbox/features/auth/domain/use_cases/reset_password.dart'
    as _i1;
import 'package:chatbox/features/auth/domain/use_cases/send_verification.dart'
    as _i614;
import 'package:chatbox/features/auth/presentation/cubit/confirm_otp_cubit/confirm_otp_cubit.dart'
    as _i393;
import 'package:chatbox/features/auth/presentation/cubit/register_cubit/register_cubit.dart'
    as _i62;
import 'package:chatbox/features/auth/presentation/cubit/reset_password_cubit/reset_password_cubit.dart'
    as _i1010;
import 'package:chatbox/features/auth/presentation/cubit/send_verification_cubit/send_verification_cubit.dart'
    as _i1013;
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
    gh.singleton<_i361.Dio>(() => registerModule.dio);
    gh.singleton<_i817.AuthRemoteDataSource>(
      () => _i719.AuthApiDataSource(gh<_i361.Dio>()),
    );
    gh.singleton<_i493.AuthRepository>(
      () => _i758.AuthRepositoryImpl(gh<_i817.AuthRemoteDataSource>()),
    );
    gh.factory<_i239.Register>(
      () => _i239.Register(gh<_i493.AuthRepository>()),
    );
    gh.lazySingleton<_i614.SendVerification>(
      () => _i614.SendVerification(gh<_i493.AuthRepository>()),
    );
    gh.lazySingleton<_i158.Otp>(() => _i158.Otp(gh<_i493.AuthRepository>()));
    gh.lazySingleton<_i1.ResetPassword>(
      () => _i1.ResetPassword(gh<_i493.AuthRepository>()),
    );
    gh.lazySingleton<_i1010.ResetPasswordCubit>(
      () => _i1010.ResetPasswordCubit(gh<_i1.ResetPassword>()),
    );
    gh.lazySingleton<_i1013.SendVerificationCubit>(
      () => _i1013.SendVerificationCubit(gh<_i614.SendVerification>()),
    );
    gh.factory<_i62.RegisterCubit>(
      () => _i62.RegisterCubit(gh<_i239.Register>()),
    );
    gh.lazySingleton<_i393.ConfirmOtpCubit>(
      () => _i393.ConfirmOtpCubit(gh<_i158.Otp>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i37.RegisterModule {}
