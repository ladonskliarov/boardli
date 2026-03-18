import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/entities/employee_entity.dart';
import '../../../domain/repositories/employee_repository.dart';
import 'base_login_cubit.dart';

class EmployeeLoginCubit extends BaseLoginCubit<EmployeeEntity> {
  final EmployeeRepository employeeRepository;
  EmployeeLoginCubit({required this.employeeRepository, required super.authCubit, required super.userType});

  @override
  Future<Either<Failure, EmployeeEntity>> performLogin({required String email, required String password}) async {
    return await employeeRepository.login(email: email, password: password);
  }

  @override
  void onLoginSuccess(EmployeeEntity user) {
    authCubit.authenticateAsEmployee();
  }
}