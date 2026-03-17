import '../../models/employee.dart';

abstract class EmployeeRemoteDatasource {
  Future<Employee> login({required String email, required String password});
  Future<Employee> register({
    required String inviteKey,
    required String password,
    required String gender,
    required String hobbies,
    required String favoriteAnimals,
  });
}
