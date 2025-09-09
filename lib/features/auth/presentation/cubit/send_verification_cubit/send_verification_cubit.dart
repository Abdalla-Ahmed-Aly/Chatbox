import 'package:chatbox/features/auth/data/model/send_verification_request.dart';
import 'package:chatbox/features/auth/presentation/cubit/send_verification_cubit/send_verification_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/send_verification.dart';
@lazySingleton
class SendVerificationCubit extends Cubit<SendVerificationStates> {
  SendVerificationCubit(this._sendVerification) : super(SendVerificationInitial());
  final SendVerification _sendVerification;
  Future<void>sendVerification(SendVerificationRequest request)async{
    emit(SendVerificationLoading());
    final result=await _sendVerification(request);
    result.fold((error) =>emit(SendVerificationFailure(error.message)) , (message) =>emit (SendVerificationSuccess(message)) ,);
  }

}
