import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/storage/interfaces/token_repository.dart';
import '../../../../core/util/enums.dart';
import '../../domain/entities/employee_entity.dart';
import '../../domain/mappers/mappers.dart';
import '../../domain/repositories/employee_repository.dart';
import '../datasource/remote/employee_remote_datasource.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeRemoteDatasource remoteDataSource;
  final TokenRepository tokenRepository;

  EmployeeRepositoryImpl({
    required this.remoteDataSource,
    required this.tokenRepository,
  });

  @override
  Future<Either<Failure, EmployeeEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.login(
        email: email,
        password: password,
      );

      await tokenRepository.saveToken(token: response.token,userType: UserType.employee);

      return Right(response.employee.toEntity());
    } catch (e) {
      return Left(ServerFailure('Internal server error'));
    }
  }

  @override
  Future<Either<Failure, EmployeeEntity>> register({
    required String inviteKey,
    required String password,
    required String gender,
    required String hobbies,
    required String favoriteAnimals,
  }) async {
    try {
      final response = await remoteDataSource.register(
        inviteKey: inviteKey,
        password: password,
        gender: gender,
        hobbies: hobbies,
        favoriteAnimals: favoriteAnimals,
      );

      await tokenRepository.saveToken(token: response.token, userType: UserType.employee);

      return Right(response.employee.toEntity());
    } catch (e) {
      return Left(ServerFailure('Internal server error'));
    }
  }

  @override
  Future<Either<Failure, EmployeeEntity>> getMe() async {
    try {
      final model = await remoteDataSource.getMe();
      return Right(model.toEntity());
    } catch (e) {
      return Left(ServerFailure('Internal server error'));
    }
  }
}
