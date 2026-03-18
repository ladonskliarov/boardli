import 'base_login_cubit.dart';

class CompanyLoginCubit extends BaseLoginCubit {
  CompanyLoginCubit({required super.authCubit, required super.userType});

  @override
  Future<void> performLogin({required String email, required String password}) async {
    await Future.delayed(Duration(seconds: 2));
  }
}