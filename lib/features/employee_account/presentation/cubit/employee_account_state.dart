part of 'employee_account_cubit.dart';

sealed class EmployeeAccountState extends Equatable {
  const EmployeeAccountState();

  @override
  List<Object> get props => [];
}

final class EmployeeAccountInitial extends EmployeeAccountState {}

final class EmployeeAccountLoading extends EmployeeAccountState {}

final class EmployeeAccountFailure extends EmployeeAccountState {
  final String message;

  const EmployeeAccountFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class EmployeeAccountLoaded extends EmployeeAccountState {
  final EmployeeEntity employee;

  const EmployeeAccountLoaded({required this.employee});

  @override
  List<Object> get props => [employee];
}