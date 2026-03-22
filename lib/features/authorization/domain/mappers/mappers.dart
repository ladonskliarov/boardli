import '../../data/models/company.dart';
import '../../data/models/employee.dart';
import '../entities/company_entity.dart';
import '../entities/employee_entity.dart';

extension CompanyMapper on Company {
  CompanyEntity toEntity() {
    return CompanyEntity(
      id: id,
      name: name,
      email: email,
      industry: industry,
      size: size,
      contactName: contactName,
    );
  }
}

extension BaseEmployeeMapper on BaseEmployee {
  BaseEmployeeEntity toEntity() {
    return BaseEmployeeEntity(
      id: id,
      name: name,
      email: email,
      department: department,
      role: role,
    );
  }
}

extension EmployeeMapper on Employee {
  EmployeeEntity toEntity() {
    return EmployeeEntity(
      id: id,
      name: name,
      email: email,
      department: department,
      role: role,
      gender: gender,
      hobbies: hobbies,
      favoriteAnimals: favoriteAnimals,
    );
  }
}

extension InvitedEmployeeMapper on InvitedEmployee {
  InvitedEmployeeEntity toEntity() {
    return InvitedEmployeeEntity(
      id: id,
      name: name,
      email: email,
      department: department,
      role: role,
    );
  }
}
