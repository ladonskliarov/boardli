part of 'employee_register_cubit.dart';

@immutable
sealed class EmployeeRegisterState extends Equatable {}

final class EmployeeRegisterInitial extends EmployeeRegisterState {
  @override
  List<Object?> get props => [];
}

final class EmployeeRegisterLoading extends EmployeeRegisterState {
  @override
  List<Object?> get props => [];
}

final class EmployeeRegisterSuccess extends EmployeeRegisterState {
  final EmployeeEntity employee;
  EmployeeRegisterSuccess({required this.employee});
  @override 
  List<Object?> get props => [employee];
}
final class EmployeeRegisterFailure extends EmployeeRegisterState {
  final String message;
  EmployeeRegisterFailure({required this.message});
  @override
  List<Object?> get props => [message];
}
