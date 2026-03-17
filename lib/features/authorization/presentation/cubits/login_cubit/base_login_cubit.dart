import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'base_login_state.dart';

abstract class BaseLoginCubit extends Cubit<BaseLoginState> {
  BaseLoginCubit() : super(BaseLoginInitial());

  Future<void> login({required String email, required String password}) async {
    try {
      emit(BaseLoginLoading());
      await performLogin(email: email, password: password);
      emit(BaseLoginSuccess());
    } catch (e) {
      emit(BaseLoginError(message: e.toString()));
    }
  }
  Future<void> performLogin({required String email, required String password});
}
