import '../../models/company.dart';

abstract class CompanyRemoteDatasource {
  Future<Company> login({required String email, required String password});
  Future<Company> register({
    required String name,
    required String industry,
    required String size,
    required String contactName,
    required String email,
    required String password,
  });
}
