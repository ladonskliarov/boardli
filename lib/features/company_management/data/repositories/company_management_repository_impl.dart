import 'package:boardli/features/authorization/domain/mappers/mappers.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../authorization/domain/entities/employee_entity.dart';
import '../../domain/repositories/company_management_repository.dart';
import '../datasource/company_management_datasource.dart';

class CompanyManagementRepositoryImpl implements CompanyManagementRepository {
  final CompanyManagementDatasource companyManagementDatasource;
  const CompanyManagementRepositoryImpl({required this.companyManagementDatasource});

  @override
  Future<Either<Failure, List<EmployeeEntity>?>> getEmployees() async {
    try {
      final response = await companyManagementDatasource.getEmployees();

      return Right(response?.map((employee) => employee.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure('Internal server error'));
    }
  }

  @override
  Future<Either<Failure, List<String>?>> getDepartments() async {
    try {
      final response = await companyManagementDatasource.getDepartments();

      return Right(response);
    } catch (e) {
      return Left(ServerFailure('Internal server error'));
    }
  }

    @override
  Future<Either<Failure, List<String>>> createDepartment({required String department}) async {
    try {
      final response = await companyManagementDatasource.createDepartment(department: department);

      return Right(response);
    } catch (e) {
      return Left(ServerFailure('Internal server error'));
    }
  }

  @override
  Future<Either<Failure, String>> createEmployeeInvite({required String name,
    required String email,
    required String department,
    required String role,}) async {
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
}