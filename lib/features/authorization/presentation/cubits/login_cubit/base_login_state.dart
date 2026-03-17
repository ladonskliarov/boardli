part of 'base_login_cubit.dart';

@immutable
sealed class BaseLoginState {}

final class BaseLoginInitial extends BaseLoginState {}
final class BaseLoginLoading extends BaseLoginState {}
final class BaseLoginSuccess extends BaseLoginState {}
final class BaseLoginError extends BaseLoginState {
  final String message;
  BaseLoginError({required this.message});
}