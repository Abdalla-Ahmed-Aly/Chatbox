import 'package:chatbox/features/auth/data/model/login_request.dart';
import 'package:chatbox/features/auth/domain/storage/i_token_storage.dart';
import 'package:chatbox/features/auth/domain/use_cases/login.dart';
import 'package:chatbox/features/auth/presentation/cubit/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(this._login, this._tokenStorage) : super(LoginInitial());

  final Login _login;
  final ITokenStorage _tokenStorage;

  Future<void> login(LoginRequest request) async {
    emit(LoginLoading());


    final result = await _login(request);

    result.fold((failure) => emit(LoginFailure(failure.message)), (
      response,
    ) async {
      await _tokenStorage.saveToken(response.token);

      final savedToken = await _tokenStorage.getToken();
      print("✅ Token Saved: $savedToken");

      emit(LoginSuccess(response.message, response.token));
    });
  }
}
