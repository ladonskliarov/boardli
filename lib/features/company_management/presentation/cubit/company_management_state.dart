part of 'company_management_cubit.dart';

sealed class CompanyManagementState extends Equatable {
  const CompanyManagementState();

  @override
  List<Object?> get props => [];
}

final class CompanyManagementInitial extends CompanyManagementState {}

final class CompanyManagementLoading extends CompanyManagementState {}

final class CompanyManagementLoaded extends CompanyManagementState {
  final List<BaseEmployeeEntity>? employees;
  final List<String>? departments;
  final String? inviteKey;
  const CompanyManagementLoaded({required this.employees, required this.departments, this.inviteKey});

  @override
  List<Object?> get props => [employees, departments, inviteKey];
}

final class CompanyManagementFailure extends CompanyManagementState {
  final String message;
  const CompanyManagementFailure({required this.message});

  @override
  List<Object?> get props => [message];
}