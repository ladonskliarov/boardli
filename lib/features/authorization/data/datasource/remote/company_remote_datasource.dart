import '../../models/company.dart';

abstract class CompanyRemoteDatasource {
  Future<({Company company, String token})> login({
    required String email,
    required String password,
  });
  Future<({Company company, String token})> register({
    required String name,
    required String industry,
    required String size,
    required String contactName,
    required String email,
    required String password,
  });
  Future<Company> getMe();
}
