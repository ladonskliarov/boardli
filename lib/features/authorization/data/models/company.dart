import '../../presentation/constants/enums.dart';
import 'package:equatable/equatable.dart';

class Company extends Equatable {
  final String id, name, contactName, email;
  final List<String>? departments;
  final IndustryType industry;
  final CompanySize size;

  const Company({
    required this.id,
    required this.name,
    required this.industry,
    required this.size,
    required this.contactName,
    required this.email,
    this.departments,
  });

  @override
  List<Object?> get props => [name, industry, size, contactName, email];

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['name'],
      industry: IndustryType.values.firstWhere(
        (e) => e.key == '${json['industry']}',
      ),
      size: CompanySize.values.firstWhere((e) => e.value == '${json['size']}'),
      departments: json['departments'] != null
          ? List<String>.from(json['departments'])
          : null,
      contactName: json['contactName'],
      email: json['email'],
    );
  }
}
