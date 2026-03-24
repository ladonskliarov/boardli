import 'package:bloc/bloc.dart';
import 'package:boardli/core/util/enums.dart';
import 'package:meta/meta.dart';

import '../../../../../core/storage/interfaces/token_repository.dart';
import '../../../domain/entities/company_entity.dart';
import '../../../domain/entities/employee_entity.dart';
import '../../../domain/repositories/company_repository.dart';
import '../../../domain/repositories/employee_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final TokenRepository tokenRepository;
  final EmployeeRepository employeeRepository;
  final CompanyRepository companyRepository;
  AuthCubit({
    required this.tokenRepository,
    required this.employeeRepository,
    required this.companyRepository,
  }) : super(AuthUnknown());

  void authenticateAsCompany(CompanyEntity company) {
    emit(AuthCompanyAuthenticated());
  }

  void authenticateAsEmployee(EmployeeEntity employee) {
    emit(AuthEmployeeAuthenticated());
  }

  Future<void> logout() async {
    await tokenRepository.deleteToken();
    emit(AuthUnauthenticated());
  }

  Future<void> checkAuth() async {
    emit(AuthUnknown());
    try {
      await tokenRepository.initToken();
      
      if (tokenRepository.hasToken) {
        final UserType? userType = tokenRepository.getCachedUserType();

        if (userType == UserType.company) {
          emit(AuthCompanyAuthenticated());

        } else if (userType == UserType.employee) {
          emit(AuthEmployeeAuthenticated());

        } else {
          tokenRepository.deleteToken();
          emit(AuthUnauthenticated());
        }
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthUnauthenticated());
    }
  }

  AuthState get currentAuthState => state;
}
