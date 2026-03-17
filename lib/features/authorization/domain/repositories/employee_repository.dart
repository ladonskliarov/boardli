import 'package:dartz/dartz.dart';

import '/core/error/failures.dart';
import '../entities/employee_entity.dart';

abstract class EmployeeRepository {
  Future<Either<Failure, EmployeeEntity>> login({
    required String email,
    required String password,
  });
  
  Future<Either<Failure, EmployeeEntity>> register({
    required String inviteKey,
    required String password,
    required String gender,
    required String hobbies,
    required String favoriteAnimals,
  });
}
