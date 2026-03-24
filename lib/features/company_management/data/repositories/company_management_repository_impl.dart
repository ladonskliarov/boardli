import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../auth/data/models/employee.dart';
import '../../../auth/domain/entities/employee_entity.dart';
import '../../../auth/domain/mappers/mappers.dart';
import '../../domain/repositories/company_management_repository.dart';
import '../datasource/company_management_datasource.dart';

class CompanyManagementRepositoryImpl implements CompanyManagementRepository {
  final CompanyManagementDatasource companyManagementDatasource;
  const CompanyManagementRepositoryImpl({
    required this.companyManagementDatasource,
  });

  @override
  Future<Either<Failure, List<BaseEmployeeEntity>?>> getEmployees() async {
    try {
      final employees = await companyManagementDatasource.getEmployees();
      final reversedEmployees = employees?.reversed.toList();
      final employeesEntities = reversedEmployees?.map((employee) {
        if (employee is Employee) {
          return employee.toEmployeeEntity('');
        } else if (employee is InvitedEmployee) {
          return employee.toInvitedEntity();
        } else {
          return employee.toBaseEntity();
        }
      }).toList();

      return Right(employeesEntities);
    } catch (e) {
      return Left(ServerFailure('Internal server error'));
    }
  }

  @override
  Future<Either<Failure, List<String>?>> getDepartments() async {
    try {
      final departments = await companyManagementDatasource.getDepartments();
      final reversedDepartments = departments?.reversed.toList();
      return Right(reversedDepartments);
    } catch (e) {
      return Left(ServerFailure('Internal server error'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> createDepartment({
    required String department,
  }) async {
    try {
      final updatedDepartments = await companyManagementDatasource
          .createDepartment(department: department);
      final reversedDepartments = updatedDepartments.reversed.toList();

      return Right(reversedDepartments);
    } catch (e) {
      return Left(ServerFailure('Internal server error'));
    }
  }

  @override
  Future<Either<Failure, String>> createEmployeeInvite({
    required String name,
    required String email,
    required String department,
    required String role,
  }) async {
    try {
      final response = await companyManagementDatasource.createEmployeeInvite(
        name: name,
        email: email,
        department: department,
        role: role,
      );

      return Right(response);
    } catch (e) {
      return Left(ServerFailure('Internal server error'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteEmployee({required String employeeId}) async {
    try {
      await companyManagementDatasource.deleteEmployee(employeeId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Internal server error'));
    }
  }
}
