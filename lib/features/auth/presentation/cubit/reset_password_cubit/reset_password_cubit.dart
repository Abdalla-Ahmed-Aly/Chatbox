import 'package:chatbox/features/auth/data/model/reset_password_request.dart';
import 'package:chatbox/features/auth/domain/use_cases/reset_password.dart';
import 'package:chatbox/features/auth/presentation/cubit/reset_password_cubit/reset_password_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordStates> {
  ResetPasswordCubit(this._resetPassword) : super(ResetPasswordInitial());
  final ResetPassword _resetPassword;
  Future<void>resetPassword(ResetPasswordRequest request)async {
    emit(ResetPasswordLoading());
    final result=await _resetPassword(request);
    result.fold((error) =>emit(ResetPasswordFailure(error.message)) , (response) =>emit(ResetPasswordSuccess(response.message)) ,);

  }
}
