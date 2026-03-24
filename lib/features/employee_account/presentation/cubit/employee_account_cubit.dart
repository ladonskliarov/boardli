import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../auth/domain/entities/employee_entity.dart';
import '../../../auth/domain/repositories/employee_repository.dart';

part 'employee_account_state.dart';

class EmployeeAccountCubit extends Cubit<EmployeeAccountState> {
  final EmployeeRepository employeeRepository;
  EmployeeAccountCubit(this.employeeRepository) : super(EmployeeAccountInitial());

  Future<void> loadEmployeeAccount() async {
    emit(EmployeeAccountLoading());
    final user = await employeeRepository.getMe();
    
    user.fold(
      (failure) => emit(EmployeeAccountFailure(message: failure.message)),
      (employee) => emit(EmployeeAccountLoaded(employee: employee)),
    );
  }

  Future<void> refreshEmployeeAccount() async {
    final user = await employeeRepository.getMe();
    
    user.fold(
      (failure) => emit(EmployeeAccountFailure(message: failure.message)),
      (employee) => emit(EmployeeAccountLoaded(employee: employee)),
    );
  }
}
