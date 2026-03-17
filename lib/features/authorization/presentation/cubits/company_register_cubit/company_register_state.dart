part of 'company_register_cubit.dart';

@immutable
sealed class CompanyRegisterState extends Equatable {}

final class CompanyRegisterInitial extends CompanyRegisterState {
  @override
  List<Object?> get props => [];
}

final class CompanyRegisterLoading extends CompanyRegisterState {
  @override
  List<Object?> get props => [];
}

final class CompanyRegisterSuccess extends CompanyRegisterState {
  final CompanyEntity company;
  CompanyRegisterSuccess({required this.company});
  @override
  List<Object?> get props => [company];
}

final class CompanyRegisterFailure extends CompanyRegisterState {
  final String message;
  CompanyRegisterFailure({required this.message});
  @override
  List<Object?> get props => [message];
}
