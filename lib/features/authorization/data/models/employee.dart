import 'package:equatable/equatable.dart';

import '../../presentation/constants/enums.dart';

class Employee extends Equatable {
  final String id, name, email;
  final List<String> departments;
  final EmployeeRole role;
  final String? password, gender, hobbies, favoriteAnimal;

  const Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.departments,
    required this.role,
    this.password,
    this.gender,
    this.hobbies,
    this.favoriteAnimal,
  });

  @override
  List<Object?> get props => [
    name,
    email,
    departments,
    role,
    password,
    gender,
    hobbies,
    favoriteAnimal,
  ];

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      departments: List<String>.from(json['departments']),
      role: EmployeeRole.values.firstWhere(
        (e) => e.toString() == 'EmployeeRole.${json['role']}',
      ),
      password: json['password'],
    );
  }
}
