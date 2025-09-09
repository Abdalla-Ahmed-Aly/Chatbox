import 'package:chatbox/features/auth/data/model/otp_request.dart';
import 'package:chatbox/features/auth/domain/use_cases/otp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'confirm_otp_states.dart';
@lazySingleton
class ConfirmOtpCubit extends Cubit<ConfirmOtpStates> {
  ConfirmOtpCubit(this._otp) : super(ConfirmOtpInitialState());
  final Otp _otp;
  Future<void>confirmOtp(OtpRequest request)async{
    emit(ConfirmOtpLoadingState());
    final result=await _otp(request);
    result.fold((error) =>emit(ConfirmOtpErrorState(error.message)) , (otp) =>emit(ConfirmOtpSuccessState(otp.message)),);


  }
}
