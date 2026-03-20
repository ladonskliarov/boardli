import '../../presentation/constants/enums.dart';
import 'user_entity.dart';

class CompanyEntity extends UserEntity {
  final String contactName;
  final IndustryType industry;
  final CompanySize size;

  CompanyEntity({
    required this.industry,
    required this.size,
    required this.contactName,
    required super.id,
    required super.name,
    required super.email,
  });
}