import '../../presentation/constants/enums.dart';

class CompanyEntity {
  final String name, contactName, email;
  final IndustryType industry;
  final CompanySize size;

  CompanyEntity({
    required this.name,
    required this.industry,
    required this.size,
    required this.contactName,
    required this.email,
  });
}