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
import 'package:chatbox/features/auth/domain/use_cases/register.dart' as _i239;
import 'package:chatbox/features/auth/domain/use_cases/send_verification.dart'
    as _i614;
import 'package:chatbox/features/auth/presentation/cubit/register_cubit/register_cubit.dart'
    as _i62;
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
    gh.singleton<_i239.Register>(
      () => _i239.Register(gh<_i493.AuthRepository>()),
    );
    gh.singleton<_i614.SendVerification>(
      () => _i614.SendVerification(gh<_i493.AuthRepository>()),
    );
    gh.singleton<_i1013.SendVerificationCubit>(
      () => _i1013.SendVerificationCubit(gh<_i614.SendVerification>()),
    );
    gh.singleton<_i62.RegisterCubit>(
      () => _i62.RegisterCubit(gh<_i239.Register>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i37.RegisterModule {}
