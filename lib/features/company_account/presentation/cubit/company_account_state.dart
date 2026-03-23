part of 'company_account_cubit.dart';

sealed class CompanyAccountState extends Equatable {
  const CompanyAccountState();

  @override
  List<Object> get props => [];
}

final class CompanyAccountInitial extends CompanyAccountState {}
final class CompanyAccountLoading extends CompanyAccountState {}
final class CompanyAccountLoaded extends CompanyAccountState {
  final CompanyEntity companyAccount;
  const CompanyAccountLoaded(this.companyAccount);
  @override
  List<Object> get props => [companyAccount];
} 
final class CompanyAccountFailure extends CompanyAccountState {
  final String message;
  const CompanyAccountFailure(this.message);
  @override
  List<Object> get props => [message];
}
