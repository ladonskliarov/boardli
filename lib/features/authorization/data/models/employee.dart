import 'package:equatable/equatable.dart';

import '../../presentation/constants/enums.dart';

class BaseEmployee extends Equatable {
  final String id, name, email, companyId, department;
  final EmployeeRole role;

  const BaseEmployee({
    required this.id,
    required this.name,
    required this.email,
    required this.department,
    required this.role,
    required this.companyId,
  });

  @override
  List<Object?> get props => [name, email, department, role];
}

class Employee extends BaseEmployee {
  final String gender, hobbies, favoriteAnimals;

  const Employee({
    required this.gender,
    required this.hobbies,
    required this.favoriteAnimals,
    required super.id,
    required super.name,
    required super.email,
    required super.department,
    required super.role,
    required super.companyId,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    department,
    role,
    gender,
    hobbies,
    favoriteAnimals,
  ];

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['_id'] ?? json['id'],
      gender: json['gender'],
      hobbies: json['hobbies'],
      favoriteAnimals: json['favoriteAnimal'],
      name: json['name'],
      email: json['email'],
      department: json['department'],
      role: EmployeeRole.values.firstWhere(
        (e) => e.toString() == 'EmployeeRole.${json['role']}',
      ),
      companyId: json['companyId'],
    );
  }
}

class InvitedEmployee extends BaseEmployee {
  const InvitedEmployee({
    required super.id,
    required super.name,
    required super.email,
    required super.department,
    required super.role,
    required super.companyId,
  });

  factory InvitedEmployee.fromJson(Map<String, dynamic> json) {
    return InvitedEmployee(
      id: json['_id'] ?? json['id'],
      name: json['name'],
      email: json['email'],
      department: json['department'],
      role: EmployeeRole.values.firstWhere(
        (e) => e.toString() == 'EmployeeRole.${json['role']}',
      ),
      companyId: json['companyId'],
    );
  }
}