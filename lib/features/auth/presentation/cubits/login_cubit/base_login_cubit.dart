import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/util/enums.dart';
import '../../../domain/entities/user_entity.dart';
import '../auth_cubit/auth_cubit.dart';

part 'base_login_state.dart';

abstract class BaseLoginCubit<T extends UserEntity> extends Cubit<BaseLoginState> {
  final AuthCubit authCubit;
  final UserType userType;
  BaseLoginCubit({required this.authCubit, required this.userType}) : super(BaseLoginInitial());

  Future<void> login({required String email, required String password}) async {
    try {
      emit(BaseLoginLoading());
      final result = await performLogin(email: email, password: password);
      result.fold(
        (failure) => emit(BaseLoginFailure(message: failure.message),),
        (user) {
          onLoginSuccess(user);
          emit(BaseLoginSuccess());
        }
      );
    } catch (e) {
      emit(BaseLoginFailure(message: e.toString()));
    }
  }
  Future<Either<Failure, T>> performLogin({required String email, required String password});
  void onLoginSuccess(T user);
}
