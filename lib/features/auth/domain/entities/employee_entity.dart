import '../../presentation/constants/enums.dart';
import 'user_entity.dart';

class BaseEmployeeEntity extends UserEntity {
  final EmployeeRole role;
  final String department;

  BaseEmployeeEntity({
    required this.department,
    required this.role,
    required super.id,
    required super.name,
    required super.email,
  });
}

class EmployeeEntity extends BaseEmployeeEntity {
  final String secondName, gender, hobbies, favoriteAnimals, avatarUrl;

  EmployeeEntity({
    required this.secondName,
    required this.gender,
    required this.hobbies,
    required this.favoriteAnimals,
    required super.department,
    required super.role,
    required super.id,
    required super.name,
    required super.email,
    required this.avatarUrl,
  });
}

class InvitedEmployeeEntity extends BaseEmployeeEntity {
  InvitedEmployeeEntity({
    required super.id,
    required super.name,
    required super.email,
    required super.department,
    required super.role,
  });
}