import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

enum AuthStatus { unknown, unauthenticated, authenticatedCompany, authenticatedEmployee }

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState(status: AuthStatus.unknown));

  void authenticateAsCompany() => emit(AuthState(status: AuthStatus.authenticatedCompany));
  void authenticateAsEmployee() => emit(AuthState(status: AuthStatus.authenticatedEmployee));
  void logout() => emit(AuthState(status: AuthStatus.unauthenticated));
}
