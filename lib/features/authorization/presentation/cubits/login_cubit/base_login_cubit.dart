import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/util/enums.dart';
import '../auth_cubit/auth_cubit.dart';

part 'base_login_state.dart';

abstract class BaseLoginCubit extends Cubit<BaseLoginState> {
  final AuthCubit authCubit;
  final UserType userType;
  BaseLoginCubit({required this.authCubit, required this.userType}) : super(BaseLoginInitial());

  Future<void> login({required String email, required String password}) async {
    try {
      emit(BaseLoginLoading());
      await performLogin(email: email, password: password);
      if (userType == UserType.employee) {
        authCubit.authenticateAsEmployee();
      } else {
        authCubit.authenticateAsCompany();
      }
      emit(BaseLoginSuccess());
    } catch (e) {
      emit(BaseLoginError(message: e.toString()));
    }
  }
  Future<void> performLogin({required String email, required String password});
}
