import 'package:equatable/equatable.dart';

import '../../presentation/constants/enums.dart';

class Employee extends Equatable {
  final String name, email;
  final List<String> departments;
  final EmployeeRole role;
  final String? password, gender, hobbies, favoriteAnimal;

  const Employee({
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
    final dynamic user = json['user'];
    return Employee(
      name: user['name'],
      email: user['email'],
      departments: List<String>.from(user['departments']),
      role: EmployeeRole.values.firstWhere(
        (e) => e.toString() == 'EmployeeRole.${user['role']}',
      ),
      password: user['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'departments': departments,
      'role': role.name,
      'password': password,
      'gender' : gender,
      'hobbies' : hobbies,
      'favoriteAnimal' : favoriteAnimal,
    };
  }
}
