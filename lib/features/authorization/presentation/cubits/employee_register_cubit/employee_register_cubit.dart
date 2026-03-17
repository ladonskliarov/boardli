import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '/features/authorization/domain/entities/employee_entity.dart';
import '../../../domain/repositories/employee_repository.dart';

part 'employee_register_state.dart';

class EmployeeRegisterCubit extends Cubit<EmployeeRegisterState> {
  final EmployeeRepository employeeRepository;
  EmployeeRegisterCubit({required this.employeeRepository})
    : super(EmployeeRegisterInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(EmployeeRegisterLoading());
    final result = await employeeRepository.login(
      email: email,
      password: password,
    );
    result.fold(
      (failure) => emit(EmployeeRegisterFailure(message: failure.message)),
      (employee) => emit(EmployeeRegisterSuccess(employee: employee)),
    );
  }

  Future<void> register({
    required String inviteKey,
    required String password,
    required String gender,
    required String hobbies,
    required String favoriteAnimals,
  }) async {
    emit(EmployeeRegisterLoading());
    final result = await employeeRepository.register(
      inviteKey: inviteKey,
      password: password,
      gender: gender,
      hobbies: hobbies,
      favoriteAnimals: favoriteAnimals,
    );
    result.fold(
      (failure) => emit(EmployeeRegisterFailure(message: failure.message)),
      (employee) => emit(EmployeeRegisterSuccess(employee: employee)),
    );
  }
}
