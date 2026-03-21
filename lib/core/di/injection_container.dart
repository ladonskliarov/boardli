import 'package:boardli/features/company_management/domain/repositories/company_management_repository.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../../features/authorization/data/datasource/remote/employee_remote_datasource.dart';
import '../../features/authorization/data/datasource/remote/employee_remote_datasource_impl.dart';
import '../../features/authorization/data/repositories/employee_repository_impl.dart';
import '../../features/authorization/domain/repositories/employee_repository.dart';
import '../../features/authorization/presentation/cubits/auth_cubit/auth_cubit.dart';
import '../../features/authorization/presentation/cubits/company_register_cubit/company_register_cubit.dart';
import '../../features/authorization/presentation/cubits/employee_register_cubit/employee_register_cubit.dart';
import '../../features/company_management/data/datasource/company_management_datasource.dart';
import '../../features/company_management/data/repositories/company_management_repository_impl.dart';
import '../../features/company_management/presentation/cubit/company_management_cubit.dart';
import '../interceptors/token_interceptor.dart';
import '../storage/implementations/token_repository_impl.dart';
import '../storage/interfaces/token_repository.dart';
import '../../features/authorization/data/datasource/remote/company_remote_datasource.dart';
import '../../features/authorization/data/datasource/remote/company_remote_datasource_impl.dart';
import '../../features/authorization/data/repositories/company_repositorty_impl.dart';
import '../../features/authorization/domain/repositories/company_repository.dart';
import '../../features/authorization/presentation/cubits/login_cubit/company_login_cubit.dart';
import '../../features/authorization/presentation/cubits/login_cubit/employee_login_cubit.dart';
import '../providers/theme_provider.dart';
import '../storage/implementations/shared_prefs_storage.dart';
import '../storage/interfaces/local_storage_service.dart';
import '../util/enums.dart';

final GetIt sl = GetIt.instance;

Future<void> initDI() async {
  _initServices();
  _registerDio();
  _registerLocalStorages();
  _registerCubits();
  _registerDAO();
  _registerRepositories();
  await _registerProviders();
  await EasyLocalization.ensureInitialized();
}

void _initServices() {
  sl.registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage());
}

void _registerDio() {
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl:
            'https://empat-final-project-backend-production.up.railway.app',
        headers: {
          'Accept' : 'application/json',
          'Content-Type' : 'application/json',
        }),
    );

    dio.interceptors.add(TokenInterceptor(tokenRepository: sl()));
    return dio;
  });
}

void _registerLocalStorages() {
  sl.registerLazySingleton<LocalStorageService>(() => SharedPrefsStorage());
}

void _registerDAO() {
  sl.registerLazySingleton<CompanyManagementDatasource>(
    () => CompanyManagementDatasource(dio: sl()),
  );
  sl.registerLazySingleton<CompanyRemoteDatasource>(
    () => CompanyRemoteDatasourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<EmployeeRemoteDatasource>(
    () => EmployeeRemoteDatasourceImpl(dio: sl()),
  );
}

void _registerRepositories() {
  sl.registerLazySingleton<TokenRepository>(
    () => TokenRepositoryImpl(secureStorage: sl()),
  );
  sl.registerLazySingleton<CompanyRepository>(
    () => CompanyRepositoryImpl(remoteDataSource: sl(), tokenRepository: sl()),
  );
  sl.registerLazySingleton<EmployeeRepository>(
    () => EmployeeRepositoryImpl(remoteDataSource: sl(), tokenRepository: sl()),
  );
  sl.registerLazySingleton<CompanyManagementRepository>(
    () => CompanyManagementRepositoryImpl(companyManagementDatasource: sl()),
  );
}

void _registerCubits() {
  sl.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
      tokenRepository: sl(),
      companyRepository: sl(),
      employeeRepository: sl(),
    ),
  );
  sl.registerFactory<EmployeeLoginCubit>(
    () => EmployeeLoginCubit(
      employeeRepository: sl(),
      authCubit: sl(),
      userType: UserType.employee,
    ),
  );
  sl.registerFactory<CompanyLoginCubit>(
    () => CompanyLoginCubit(
      companyRepository: sl(),
      authCubit: sl(),
      userType: UserType.company,
    ),
  );
  sl.registerFactory<CompanyRegisterCubit>(
    () => CompanyRegisterCubit(authCubit: sl(), companyRepository: sl()),
  );
  sl.registerFactory<EmployeeRegisterCubit>(
    () => EmployeeRegisterCubit(authCubit: sl(), employeeRepository: sl()),
  );
  sl.registerFactory<CompanyManagementCubit>(() => CompanyManagementCubit(companyManagementRepository: sl()));
}

Future<void> _registerProviders() async {
  final LocalStorageService localStorageService = sl();
  final darkTheme = await localStorageService.getDarkTheme();
  sl.registerLazySingleton<ThemeProvider>(
    () => ThemeProvider(darkTheme: darkTheme),
  );
}
