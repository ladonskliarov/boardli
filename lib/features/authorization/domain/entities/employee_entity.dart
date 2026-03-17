import '../../presentation/constants/enums.dart';

class EmployeeEntity {
  final String name, email;
  final List<String> departments;
  final EmployeeRole role;
  final String? password, gender, hobbies;

  EmployeeEntity({
    required this.name,
    required this.email,
    required this.departments,
    required this.role,
    required this.gender,
    required this.hobbies,
    required this.password,
  });
}
