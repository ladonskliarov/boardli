import '../../presentation/constants/enums.dart';
import 'user_entity.dart';

class EmployeeEntity extends UserEntity {
  final List<String> departments;
  final EmployeeRole role;
  final String? password, gender, hobbies;

  EmployeeEntity({
    required this.departments,
    required this.role,
    required this.gender,
    required this.hobbies,
    required this.password,
    required super.id,
    required super.name,
    required super.email,
  });
}
