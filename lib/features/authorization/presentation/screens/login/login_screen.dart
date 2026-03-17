import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/di/injection_container.dart';
import '../../../../../core/router.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_dimensions.dart';
import '../../../../../core/util/extensions.dart';
import '../../../../../core/util/validator.dart';
import '../../cubits/login_cubit/base_login_cubit.dart';
import '../../cubits/login_cubit/company_login_cubit.dart';
import '../../cubits/login_cubit/employee_login_cubit.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/header.dart';

class LoginScreen extends StatefulWidget {
  final String userType;
  const LoginScreen({required this.userType, super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<BaseLoginCubit, BaseLoginState>(
      bloc: widget.userType == 'employee'
          ? sl<EmployeeLoginCubit>()
          : sl<CompanyLoginCubit>(),
      listener: (context, state) {
        if (state is BaseLoginSuccess) {
          //TODO continue
          context.goNamed(AppPage.employeeDashboard.name);
        }
      },
      child: Scaffold(
          backgroundColor: AppColors.gunMetal,
          body: Stack(
            children: [
              Center(
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: 280.ph,
                    maxHeight: double.infinity,
                  ),
                  margin: Paddings.paddingHorizontalL,
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: .circular(30.0),
                  ),
                  child: Padding(
                    padding: Paddings.paddingAllM,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: .min,
                        mainAxisAlignment: .spaceBetween,
                        crossAxisAlignment: .start,
                        children: [
                          CustomTextField(
                            title: 'Email',
                            titleColor: AppColors.white,
                            errorColor: AppColors.white,
                            validator: Validator.validateEmail,
                            controller: _emailController,
                          ),
                          gapH10,
                          CustomTextField(
                            title: 'Password',
                            titleColor: AppColors.white,
                            errorColor: AppColors.white,
                            validator: Validator.validateRegisterPassword,
                            controller: _passwordController,
                          ),
                          gapH20,
                          Align(
                            alignment: .centerRight,
                            child: CustomButton(
                              text: 'Sign in',
                              elevation: 4,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              HeaderWidget(subtitle: 'Welcome back!', headerType: .convexOut, color: AppColors.tiger),
            ],
          ),
        ),
    );
  }
}
