import 'base_login_cubit.dart';

class EmployeeLoginCubit extends BaseLoginCubit {
  EmployeeLoginCubit({required super.authCubit, required super.userType});

  @override
  Future<void> performLogin({required String email, required String password}) async {
    await Future.delayed(Duration(seconds: 2));
  }
}