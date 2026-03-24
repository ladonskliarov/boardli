part of 'auth_cubit.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthUnknown extends AuthState {}

final class AuthUnauthenticated extends AuthState {}

sealed class AuthAuthenticated extends AuthState {
  const AuthAuthenticated();
}

final class AuthCompanyAuthenticated extends AuthAuthenticated {}

final class AuthEmployeeAuthenticated extends AuthAuthenticated {}