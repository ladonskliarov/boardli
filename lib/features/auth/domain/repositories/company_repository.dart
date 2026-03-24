import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/company_entity.dart';

abstract class CompanyRepository {
  Future<Either<Failure, CompanyEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, CompanyEntity>> register({
    required String name,
    required String industry,
    required String size,
    required String contactName,
    required String email,
    required String password,
  });

  Future<Either<Failure, CompanyEntity>> getMe();
}
