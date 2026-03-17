import '../../presentation/constants/enums.dart';
import 'package:equatable/equatable.dart';

class Company extends Equatable {
  final String name, contactName, email;
  final IndustryType industry;
  final CompanySize size;

  const Company({
    required this.name,
    required this.industry,
    required this.size,
    required this.contactName,
    required this.email,
  });

  @override
  List<Object?> get props => [
    name,
    industry,
    size,
    contactName,
    email,
  ];

  factory Company.fromJson(Map<String, dynamic> json) {
    final dynamic user = json['user'];
    return Company(
      name: user['name'],
      industry: IndustryType.values.firstWhere((e) => '${e.runtimeType}.${e.name}' == '${user['industry']}'),
      size: CompanySize.values.firstWhere((e) => e.value == '${user['size']}'),
      contactName: user['contactName'],
      email: user['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'industry': industry.name,
      'size': size.value,
      'contactName': contactName,
      'email': email,
    };
  }
}
