import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../authorization/domain/entities/employee_entity.dart';

abstract class CompanyManagementRepository {
  Future<Either<Failure, List<EmployeeEntity>?>> getEmployees();
  Future<Either<Failure, List<String>?>> getDepartments();
  Future<Either<Failure, String>> createEmployeeInvite({required String name, required String email, required String department, required String role});
  Future<Either<Failure, List<String>>> createDepartment({required String department});
}