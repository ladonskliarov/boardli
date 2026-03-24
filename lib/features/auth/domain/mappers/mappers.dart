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
  BaseEmployeeEntity toBaseEntity() {
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
  EmployeeEntity toEmployeeEntity(String avatarUrl) {
    getName() {
      final parts = name.split(' ');
      return parts.length > 1 ? parts[0] : name;
    }

    getSecondName() {
      final parts = name.split(' ');
      return parts.length > 1 ? parts[1] : '';
    }
    return EmployeeEntity(
      id: id,
      name: getName(),
      secondName: getSecondName(),
      email: email,
      department: department,
      role: role,
      gender: gender,
      hobbies: hobbies,
      favoriteAnimals: favoriteAnimals,
      avatarUrl: 'https://$avatarUrl',
    );
  }
}

extension InvitedEmployeeMapper on InvitedEmployee {
  InvitedEmployeeEntity toInvitedEntity() {
    return InvitedEmployeeEntity(
      id: id,
      name: name,
      email: email,
      department: department,
      role: role,
    );
  }
}
