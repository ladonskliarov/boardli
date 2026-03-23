import '../../models/employee.dart';

abstract class EmployeeRemoteDatasource {
  Future<({Employee employee, String token})> login({required String email, required String password});
  Future<({Employee employee, String token})> register({
    required String inviteKey,
    required String password,
    required String gender,
    required String hobbies,
    required String favoriteAnimals,
  });
  Future<Employee> getMe();
  Future<String> getAvatar();
}
