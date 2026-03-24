import 'package:dartz/dartz.dart';

import '../../../domain/entities/company_entity.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/repositories/company_repository.dart';
import 'base_login_cubit.dart';

class CompanyLoginCubit extends BaseLoginCubit<CompanyEntity> {
  final CompanyRepository companyRepository;
  CompanyLoginCubit({required this.companyRepository, required super.authCubit, required super.userType});

  @override
  Future<Either<Failure, CompanyEntity>> performLogin({required String email, required String password}) async {
    return await companyRepository.login(email: email, password: password);
  }

  @override
  void onLoginSuccess(CompanyEntity company) {
    authCubit.authenticateAsCompany(company);
  }
}