import 'package:dartz/dartz.dart';

import '../../../../core/storage/interfaces/token_repository.dart';
import '../../../../core/util/enums.dart';
import '/features/authorization/domain/entities/company_entity.dart';
import '/features/authorization/domain/mappers/mappers.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/company_repository.dart';
import '../datasource/remote/company_remote_datasource.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  final CompanyRemoteDatasource remoteDataSource;
  final TokenRepository tokenRepository;
  CompanyRepositoryImpl({
    required this.remoteDataSource,
    required this.tokenRepository,
  });

  @override
  Future<Either<Failure, CompanyEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.login(
        email: email,
        password: password,
      );

      await tokenRepository.saveToken(token: response.token, userType: UserType.company);

      return Right(response.company.toEntity());
    } catch (e) {
      return Left(ServerFailure('Internal server error'));
    }
  }

  @override
  Future<Either<Failure, CompanyEntity>> register({
    required String name,
    required String industry,
    required String size,
    required String contactName,
    required String email,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.register(
        name: name,
        industry: industry,
        size: size,
        contactName: contactName,
        email: email,
        password: password,
      );

      await tokenRepository.saveToken(token: response.token, userType: UserType.company);

      return Right(response.company.toEntity());
    } catch (e) {
      return Left(ServerFailure('Internal server error'));
    }
  }

  @override
  Future<Either<Failure, CompanyEntity>> getMe() async {
    try {
      final model = await remoteDataSource.getMe();
      
      return Right(model.toEntity());
    } catch (e) {
      return Left(ServerFailure('Internal server error'));
    }
  }
}
