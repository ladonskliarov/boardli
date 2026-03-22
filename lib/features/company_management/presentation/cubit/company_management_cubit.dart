import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../authorization/domain/entities/employee_entity.dart';
import '../../domain/repositories/company_management_repository.dart';

part 'company_management_state.dart';

class CompanyManagementCubit extends Cubit<CompanyManagementState> {
  final CompanyManagementRepository companyManagementRepository;

  CompanyManagementCubit({required this.companyManagementRepository})
    : super(CompanyManagementInitial());

  Future<void> loadOrganizationData({String? inviteKey}) async {
    emit(CompanyManagementLoading());

    final employeesResult = await companyManagementRepository.getEmployees();
    final departmentsResult = await companyManagementRepository
        .getDepartments();

    employeesResult.fold(
      (failure) => emit(CompanyManagementFailure(message: failure.message)),
      (employees) {
        departmentsResult.fold(
          (failure) => emit(CompanyManagementFailure(message: failure.message)),
          (departments) => emit(
            CompanyManagementLoaded(
              employees: employees,
              departments: departments,
              inviteKey: inviteKey,
            ),
          ),
        );
      },
    );
  }

  Future<void> createEmployeeInvite({
    required String name,
    required String email,
    required String department,
    required String role,
  }) async {
    final result = await companyManagementRepository.createEmployeeInvite(
      name: name,
      email: email,
      department: department,
      role: role,
    );

    result.fold(
      (failure) => emit(CompanyManagementFailure(message: failure.message)),
      (key) => loadOrganizationData(inviteKey: key),
    );
  }

  Future<void> createDepartment({required String department}) async {
    final result = await companyManagementRepository.createDepartment(
      department: department,
    );

    result.fold(
      (failure) => emit(CompanyManagementFailure(message: failure.message)),
      (success) => loadOrganizationData(),
    );
  }

  Future<void> deleteInviteKey() async {
    emit(
      CompanyManagementLoaded(
        employees: (state as CompanyManagementLoaded).employees,
        departments: (state as CompanyManagementLoaded).departments,
        inviteKey: null,
      ),
    );
  }
}
