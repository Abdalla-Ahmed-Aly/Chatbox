import 'package:chatbox/features/auth/data/model/register_request.dart';
import 'package:chatbox/features/auth/presentation/cubit/register_cubit/register_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/use_cases/register.dart';
@singleton
class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._register) : super(RegisterInitial());
final Register _register;

 Future<void>register(RegisterRequest request)async{
   emit(RegisterLoading());
  final result=await _register(request);
  result.fold((error) =>emit(RegisterFailure(error.message)) , (message) =>emit(RegisterSuccess(message)),);

 }
}
