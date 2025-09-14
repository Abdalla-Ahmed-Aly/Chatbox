import 'package:chatbox/features/auth/data/model/register_request.dart';
import 'package:chatbox/features/auth/domain/storage/i_token_storage.dart';
import 'package:chatbox/features/auth/presentation/cubit/register_cubit/register_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/use_cases/register.dart';

@injectable
class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit(this._register, this._tokenStorage) : super(RegisterInitial());

  final Register _register;
  final ITokenStorage _tokenStorage;

  Future<void> register(RegisterRequest request) async {
    emit(RegisterLoading());
    final result = await _register(request);

    result.fold(
      (error) => emit(RegisterFailure(error.message)),
      (response) async {
        await _tokenStorage.saveToken(response.token);

        final savedToken = await _tokenStorage.getToken();
        print("✅ Token Saved after Register: $savedToken");

        emit(RegisterSuccess(response.message, response.token));
      },
    );
  }
}
