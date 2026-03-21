part of 'company_management_cubit.dart';

sealed class CompanyManagementState extends Equatable {
  const CompanyManagementState();

  @override
  List<Object?> get props => [];
}

final class CompanyManagementInitial extends CompanyManagementState {}

final class CompanyManagementLoading extends CompanyManagementState {}

final class CompanyManagementLoaded extends CompanyManagementState {
  final List<EmployeeEntity>? employees;
  final List<String>? departments;
  const CompanyManagementLoaded({required this.employees, required this.departments});

  @override
  List<Object?> get props => [employees, departments];
}

final class CompanyManagementFailure extends CompanyManagementState {
  final String message;
  const CompanyManagementFailure({required this.message});

  @override
  List<Object?> get props => [message];
}