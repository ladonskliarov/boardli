import 'package:dartz/dartz.dart';

import '/features/authorization/domain/entities/company_entity.dart';
import '/features/authorization/domain/mappers/mappers.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/company_repository.dart';
import '../datasource/remote/company_remote_datasource.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  final CompanyRemoteDatasource remoteDataSource;

  CompanyRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, CompanyEntity>> login({required String email, required String password}) async {
    try {
      final model = await remoteDataSource.login(email: email, password: password);
      return Right(model.toEntity());
    } catch (e) {
      return Left(ServerFailure('Internal server error'));
    }
  }
  
  @override
  Future<Either<Failure, CompanyEntity>> register({required String name, required String industry, required String size, required String contactName, required String email, required String password}) async {
    try {
      final model = await remoteDataSource.register(
        name: name,
        industry: industry,
        size: size,
        contactName: contactName,
        email: email,
        password: password,
      );
      return Right(model.toEntity());
    } catch (e) {
      return Left(ServerFailure('Internal server error'));
    }
  }
}