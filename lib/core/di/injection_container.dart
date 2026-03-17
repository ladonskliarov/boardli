import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../../features/authorization/data/datasource/remote/employee_remote_datasource.dart';
import '../../features/authorization/data/datasource/remote/employee_remote_datasource_impl.dart';
import '../../features/authorization/data/repository/employee_repository_impl.dart';
import '../../features/authorization/domain/repositories/employee_repository.dart';
import '../../features/authorization/presentation/cubits/auth_cubit/auth_cubit.dart';
import '../../features/authorization/presentation/cubits/company_register_cubit/company_register_cubit.dart';
import '../../features/authorization/presentation/cubits/employee_register_cubit/employee_register_cubit.dart';
import '../storage/implementations/secure_local_storage_impl.dart';
import '../storage/interfaces/secure_local_storage.dart';
import '../../features/authorization/data/datasource/remote/company_remote_datasource.dart';
import '../../features/authorization/data/datasource/remote/company_remote_datasource_impl.dart';
import '../../features/authorization/data/repository/company_repositorty_impl.dart';
import '../../features/authorization/domain/repositories/company_repository.dart';
import '../../features/authorization/presentation/cubits/login_cubit/company_login_cubit.dart';
import '../../features/authorization/presentation/cubits/login_cubit/employee_login_cubit.dart';
import '../providers/theme_provider.dart';
import '../storage/implementations/shared_prefs_storage.dart';
import '../storage/interfaces/local_storage_service.dart';

final GetIt sl = GetIt.instance;

Future<void> initDI() async {
  _registerLocalStorages();
  _registerBlocs();
  _registerDAO();
  _registerRepositories();
  await _registerProviders();
  await EasyLocalization.ensureInitialized();
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage());
}

void _registerLocalStorages() {
  sl.registerLazySingleton<LocalStorageService>(() => SharedPrefsStorage());
  sl.registerLazySingleton<SecureLocalStorage>(() => SecureLocalStorageImpl(secureStorage: sl()));
}

void _registerDAO() {
  sl.registerLazySingleton<CompanyRemoteDatasource>(() => CompanyRemoteDatasourceImpl(sl()));
  sl.registerLazySingleton<EmployeeRemoteDatasource>(() => EmployeeRemoteDatasourceImpl(sl()));
}

void _registerRepositories() {
  sl.registerLazySingleton<CompanyRepository>(() => CompanyRepositoryImpl(sl()));
  sl.registerLazySingleton<EmployeeRepository>(() => EmployeeRepositoryImpl(sl()));
}

void _registerBlocs() {
  sl.registerFactory<EmployeeLoginCubit>(() => EmployeeLoginCubit());
  sl.registerFactory<CompanyLoginCubit>(() => CompanyLoginCubit());
  sl.registerFactory<CompanyRegisterCubit>(() => CompanyRegisterCubit(companyRepository: sl()));
  sl.registerFactory<EmployeeRegisterCubit>(() => EmployeeRegisterCubit(employeeRepository: sl()));
  sl.registerFactory<AuthCubit>(() => AuthCubit());
}

Future<void> _registerProviders() async {
  final LocalStorageService localStorageService = sl();
  final darkTheme = await localStorageService.getDarkTheme();
  sl.registerLazySingleton<ThemeProvider>(() => ThemeProvider(darkTheme: darkTheme));
}
