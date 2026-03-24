import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/di/injection_container.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_dimensions.dart';
import '../../../../../core/util/enums.dart';
import '../../../../../core/util/extensions.dart';
import '../../../../../core/util/validator.dart';
import '../../cubits/login_cubit/base_login_cubit.dart';
import '../../cubits/login_cubit/company_login_cubit.dart';
import '../../cubits/login_cubit/employee_login_cubit.dart';
import '../../../../../core/style/widgets/custom_button.dart';
import '../../../../../core/style/widgets/custom_text_field.dart';
import '../../widgets/header.dart';
import '../../widgets/loading_dialog.dart';

class LoginScreen extends StatefulWidget {
  final UserType userType;
  const LoginScreen({required this.userType, super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  BaseLoginCubit _getLoginCubit() {
    if (widget.userType == UserType.employee) {
      return sl<EmployeeLoginCubit>();
    } else {
      return sl<CompanyLoginCubit>();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _getLoginCubit(),
      child: BlocListener<BaseLoginCubit, BaseLoginState>(
        listener: (context, state) {
          if (state is BaseLoginLoading) {
            showLoadingDialog(context);
          } else if (state is BaseLoginFailure) {
            context.pop();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: LoginScreenView(
          formKey: _formKey,
          emailController: _emailController,
          passwordController: _passwordController,
        ),
      ),
    );
  }
}

class LoginScreenView extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const LoginScreenView({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: Stack(
            children: [
              Center(
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: 280.ph,
                    maxHeight: double.infinity,
                  ),
                  margin: Paddings.paddingHorizontal20,
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: .circular(30.0),
                  ),
                  child: Padding(
                    padding: Paddings.paddingAll16,
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: .min,
                        mainAxisAlignment: .spaceBetween,
                        crossAxisAlignment: .start,
                        children: [
                          CustomTextField(
                            title: 'login_screen.email_label'.tr(),
                            titleColor: AppColors.white,
                            errorColor: AppColors.white,
                            validator: Validator.validateEmail,
                            controller: emailController,
                          ),
                          gapH10,
                          CustomTextField(
                            title: 'login_screen.password_label'.tr(),
                            obscureText: true,
                            titleColor: AppColors.white,
                            errorColor: AppColors.white,
                            validator: Validator.validateRegisterPassword,
                            controller: passwordController,
                          ),
                          gapH20,
                          Align(
                            alignment: Alignment.centerRight,
                            child: CustomButton(
                              text: 'login_screen.sign_in_button'.tr(),
                              backgroundColor: AppColors.grey,
                              elevation: 4,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  BlocProvider.of<BaseLoginCubit>(
                                    context,
                                  ).login(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              HeaderWidget(
                textColor: AppColors.white,
                subtitle: 'login_screen.welcome_back'.tr(),
                headerType: HeaderType.convexOut,
                color: AppColors.tiger,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
