# Boardli Mobile Architecture

This document describes the actual architecture of the current Boardli Mobile Flutter codebase.

## 1. High-Level Architecture

The project follows a **feature-oriented** structure with reusable cross-cutting logic in `lib/core`.

- `lib/core` contains shared platform logic (routing, DI, storage, networking, theming, utilities).
- `lib/features` contains business modules (auth, account, knowledge base, assistant, etc.).
- Most features use a layered split:
  - `data` (datasources/models/repository implementation)
  - `domain` (entities/repository contracts/mappers)
  - `presentation` (screens/widgets/cubits)

State is managed with **Cubit/BLoC** and service resolution is done via **GetIt**.

## 2. Folder Structure

## Top-level directories

- `lib/` - Flutter source code.
- `assets/` - icons and localization JSONs.
- `android/`, `ios/`, `web/`, `windows/`, `macos/`, `linux/` - platform runners.
- `pubspec.yaml` - dependencies, assets, fonts.
- `analysis_options.yaml` - lint config.
- `native_splash.yaml` - splash generation config.

## `lib/` structure

- `lib/main.dart`
  - app bootstrap (`initDI`, auth check, localization/provider setup, `MaterialApp.router`).
- `lib/core/di/injection_container.dart`
  - service locator registration (Dio, repositories, cubits, providers, storage).
- `lib/core/router/router.dart`
  - route definitions and auth-based redirects.
- `lib/core/interceptors/token_interceptor.dart`
  - attaches JWT bearer token to outgoing requests.
- `lib/core/storage/`
  - `TokenRepositoryImpl` (`flutter_secure_storage`) for JWT/user role.
  - `SharedPrefsStorage` (`shared_preferences`) for theme and locale.
- `lib/features/*`
  - feature modules described below.

## 3. State Management

## BLoC/Cubit pattern in this project

The codebase uses `Cubit` heavily (from `bloc`/`flutter_bloc`) and follows a standard state flow:

1. UI triggers a Cubit method.
2. Cubit emits loading/success/failure states.
3. UI rebuilds or reacts via `BlocBuilder` / `BlocListener`.

Example from login:

```dart
// lib/features/auth/presentation/cubits/login_cubit/base_login_cubit.dart
Future<void> login({required String email, required String password}) async {
  emit(BaseLoginLoading());
  final result = await performLogin(email: email, password: password);
  result.fold(
    (failure) => emit(BaseLoginFailure(message: failure.message)),
    (user) {
      onLoginSuccess(user);
      emit(BaseLoginSuccess());
    },
  );
}
```

## UI bindings (`flutter_bloc`)

The app uses:

- `BlocBuilder` for rendering state-dependent UI:
  - `CompanyManagementScreen`
  - `KnowledgeBaseScreen`
  - `CompanyAccountScreen`
  - `EmployeeAccountScreen`
  - `EmployeeChatAssistantScreen`
- `BlocListener` for one-time UI effects:
  - `LoginScreen`
  - `CompanyRegisterScreen`
  - `EmployeeRegisterScreen`

Example:

```dart
// lib/features/auth/presentation/screens/login/login_screen.dart
BlocListener<BaseLoginCubit, BaseLoginState>(
  listener: (context, state) {
    if (state is BaseLoginLoading) {
      showLoadingDialog(context);
    } else if (state is BaseLoginFailure) {
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  },
  child: LoginScreenView(...),
)
```

## GetIt service locator

`initDI()` registers:

- Core services (`FlutterSecureStorage`, `Dio`, providers).
- Datasources (`CompanyRemoteDatasourceImpl`, `EmployeeRemoteDatasourceImpl`, etc.).
- Repositories (`CompanyRepositoryImpl`, `EmployeeRepositoryImpl`, etc.).
- Cubits (`AuthCubit`, login/register cubits, account cubits, feature cubits).

Key file: `lib/core/di/injection_container.dart`.

## 4. Navigation

Navigation is configured in `lib/core/router/router.dart` using `GoRouter`.

## Route model

`AppPage` enum defines paths:

- Auth routes:
  - `authorization('/')`
  - `login('login')`
  - `registerCompany('company-tariff/register')`
  - `registerEmployee('register-employee')`
- Employee routes:
  - `/employee-account`
  - `/chat-assistant`
  - `/employee-knowledge-base`
- Company routes:
  - `/company-account`
  - `/company-organization`
  - `/company-knowledge-base`

## Auth guards and redirect logic

Router refreshes from `AuthCubit` stream (`GoRouterRefreshStream`).
Redirect behavior:

- Unauthenticated users attempting protected routes are sent to `/`.
- Authenticated company users are redirected to `/company-account` from auth routes.
- Authenticated employee users are redirected to `/employee-account` from auth routes.

Core logic:

```dart
// lib/core/router/router.dart
if ((authState is AuthUnknown || authState is AuthUnauthenticated) && !isAuthRoute) {
  return AppPage.authorization.path;
}
if (authState is AuthCompanyAuthenticated && isAuthRoute) {
  return AppPage.companyAccount.path;
}
if (authState is AuthEmployeeAuthenticated && isAuthRoute) {
  return AppPage.employeeAccount.path;
}
```

## Role-based routing

Two separate `StatefulShellRoute.indexedStack` trees are defined:

- **Employee shell** (`EmployeeDashboardScreen`)
  - account / chat assistant / knowledge base tabs.
- **Company shell** (`CompanyDashboardScreen`)
  - company account / organization management / knowledge base tabs.

## 5. Data Layer

## Dio configuration

Defined in `injection_container.dart`:

- `baseUrl` set via `BaseOptions` (currently hardcoded in source).
- default headers: `Accept`, `Content-Type`.
- `TokenInterceptor` added to inject auth headers.

## JWT attachment

`TokenInterceptor` reads token from `TokenRepository` and attaches:

```dart
options.headers['Authorization'] = 'Bearer $token';
```

## Repository pattern

Repositories wrap datasources and return `Either<Failure, T>`.

Examples:

- `CompanyRepositoryImpl`
- `EmployeeRepositoryImpl`
- `CompanyManagementRepositoryImpl`
- `ChatAssistantRepositoryImpl`
- `KnowledgeBaseRepository`

## Error handling strategy in data layer

- Base failure type: `Failure` (`lib/core/error/failures.dart`)
- Current concrete failure: `ServerFailure`.
- Datasources throw failures/exceptions.
- Repositories convert thrown errors into `Left(ServerFailure(...))`.

Note: multiple repository implementations currently return generic `"Internal server error"` on catch.

## Local storage split

- `flutter_secure_storage` (`TokenRepositoryImpl`)
  - `jwt_token`
  - `user_type`
- `shared_preferences` (`SharedPrefsStorage`)
  - dark theme toggle
  - language code

## 6. Authentication Flow

## Bootstrapping auth

At startup (`main.dart`):

1. `initDI()`
2. `sl<AuthCubit>().checkAuth()`
3. Router uses auth state for redirects.

## Login flows

- Company login:
  - UI: `LoginScreen(userType: UserType.company)`
  - Cubit: `CompanyLoginCubit`
  - API: `POST /api/v1/auth/company/login`
  - On success: token stored, `AuthCubit.authenticateAsCompany(...)`

- Employee login:
  - UI: `LoginScreen(userType: UserType.employee)`
  - Cubit: `EmployeeLoginCubit`
  - API: `POST /api/v1/auth/employee/login`
  - On success: token stored, `AuthCubit.authenticateAsEmployee(...)`

## Registration flows

- Company register:
  - Cubit: `CompanyRegisterCubit`
  - API: `POST /api/v1/auth/company/register`
  - On success: token saved + company authenticated.

- Employee register:
  - Cubit: `EmployeeRegisterCubit`
  - API: `POST /api/v1/auth/employee/register`
  - Uses invite key (`token`) and also sends `Authorization: Bearer <inviteKey>` in request options.
  - On success: token saved + employee authenticated.

## Token refresh

No explicit refresh-token flow was found.
Current implementation persists and reuses access token from secure storage.

## 7. Features / Modules

## `auth`

Purpose:

- Entry authentication and role selection.
- Company and employee login/registration.

Presentation:

- Screens:
  - `AuthScreen`
  - `LoginScreen`
  - `CompanyRegisterScreen`
  - `EmployeeRegisterScreen`
- Cubits:
  - `AuthCubit`
  - `CompanyLoginCubit`, `EmployeeLoginCubit`, `BaseLoginCubit`
  - `CompanyRegisterCubit`
  - `EmployeeRegisterCubit`

Data/API:

- `CompanyRemoteDatasourceImpl`
  - `POST /api/v1/auth/company/login`
  - `POST /api/v1/auth/company/register`
  - `GET /api/v1/auth/me`
- `EmployeeRemoteDatasourceImpl`
  - `POST /api/v1/auth/employee/login`
  - `POST /api/v1/auth/employee/register`
  - `GET /api/v1/auth/me`
  - `POST /api/v1/ai/avatar-url`

## `employee_account`

Purpose:

- Display employee profile/account info.

State:

- `EmployeeAccountCubit`
  - `loadEmployeeAccount()`
  - `refreshEmployeeAccount()`

Data/API:

- Through `EmployeeRepository.getMe()` -> employee profile + avatar URL.

Screen:

- `EmployeeAccountScreen`

## `company_account`

Purpose:

- Display company profile/account info.

State:

- `CompanyAccountCubit`
  - `loadCompanyAccount()`
  - `refreshCompanyAccount()`

Data/API:

- Through `CompanyRepository.getMe()` -> `GET /api/v1/auth/me`.

Screen:

- `CompanyAccountScreen`

## `company_management`

Purpose:

- Manage organization entities for company users.

State:

- `CompanyManagementCubit`
  - `loadOrganizationData`
  - `createEmployeeInvite`
  - `createDepartment`
  - `deleteEmployee`
  - `refreshData`

Data/API (`CompanyManagementDatasource`):

- `GET /api/v1/employees`
- `GET /api/v1/companies/me/departments`
- `POST /api/v1/companies/invite-employee`
- `POST /api/v1/companies/me/departments`
- `DELETE /api/v1/employees/{employeeId}`

Screens:

- `CompanyManagementScreen`
- `tabs/EmployeesTab`
- `tabs/DepartmentsTab`

## `knowledge_base`

Purpose:

- Shared resources upload and browsing for both roles.

State:

- `KnowledgeBaseCubit`
  - `getResources`
  - `uploadFile`
  - `uploadLink`
  - `deleteResource`
  - `refreshResources`

Data/API (`KnowledgeBaseDatasource`):

- `GET /api/v1/resources`
- `POST /api/v1/resources/upload`
- `POST /api/v1/resources/url`
- `DELETE /api/v1/resources/{resourceId}`

Screens:

- `KnowledgeBaseScreen`
- `tabs/BrowseTab`
- `tabs/UploadTab`

## `chat_assistant`

Purpose:

- Employee-facing AI chat assistant.

State:

- `ChatAssistantCubit`
  - `loadChatHistory`
  - `sendMessage`
  - `refreshChat`

Data/API (`ChatAssistantDatasource`):

- `POST /api/v1/ai/chat`
- `GET /api/v1/ai/history`

Screen:

- `EmployeeChatAssistantScreen`

## `dashboard`

Purpose:

- Role-specific shell screens with bottom navigation and nested branches.

Screens:

- `EmployeeDashboardScreen`
- `CompanyDashboardScreen`

Behavior:

- Each dashboard wires feature cubits via `MultiBlocProvider` and preloads initial data for tab content.

## 8. Assets

## Icons (`assets/icons/`)

Referenced in `lib/core/style/app_icons.dart`:

- `account.svg`
- `company.svg`
- `arrow-down.svg`
- `eye.svg`
- `eye-off.svg`
- `chat-assistant.svg`
- `upload.svg`
- `organization.svg`

## Translations (`easy_localization`)

- Path configured in `main.dart`: `assets/translations`.
- Supported locales:
  - `Locale('uk')`
  - `Locale('en')`
- Files:
  - `assets/translations/en.json`
  - `assets/translations/uk.json`

Locale toggle is handled by `LocaleProvider` and persisted via `SharedPrefsStorage`.

## Fonts

`pubspec.yaml` registers family `e-Ukraine` with weights:

- 100 `e-Ukraine-UltraLight.otf`
- 200 `e-Ukraine-Thin.otf`
- 300 `e-Ukraine-Light.otf`
- 400 `e-Ukraine-Regular.otf`
- 500 `e-Ukraine-Medium.otf`
- 700 `e-Ukraine-Bold.otf`

## 9. Error Handling and User Feedback

## Error propagation

- Datasource layer throws typed failures/exceptions.
- Repository layer converts to `Either<Failure, T>`.
- Cubits map failures into state classes (e.g., `CompanyManagementFailure`).
- UI listens and displays:
  - loading dialogs / progress indicators
  - snack bars (auth screens)
  - textual error placeholders in content screens

## Typical UI pattern

1. `emit(Loading)`
2. repository call
3. `emit(Success)` or `emit(Failure(message))`
4. `BlocBuilder`/`BlocListener` updates UI.
