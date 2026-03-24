import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/loading_dialog.dart';
import '../../../../../core/di/injection_container.dart';
import '../../cubits/company_register_cubit/company_register_cubit.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_dimensions.dart';
import '../../../../../core/util/validator.dart';
import '../../constants/enums.dart';
import '../../../../../core/style/widgets/custom_button.dart';
import '../../../../../core/style/widgets/custom_dropdown_button.dart';
import '../../../../../core/style/widgets/custom_text_field.dart';
import '../../widgets/header.dart';

class CompanyRegisterScreen extends StatefulWidget {
  const CompanyRegisterScreen({super.key});

  @override
  State<CompanyRegisterScreen> createState() => _CompanyRegisterScreenState();
}

class _CompanyRegisterScreenState extends State<CompanyRegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _industryController = TextEditingController();
  final TextEditingController _companySizeController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final ValueNotifier<EnumValue> _companySize = ValueNotifier<EnumValue>(
    CompanySize.small,
  );
  final ValueNotifier<EnumValue> _industry = ValueNotifier<EnumValue>(
    IndustryType.technology,
  );

  @override
  void dispose() {
    _companyNameController.dispose();
    _industryController.dispose();
    _companySizeController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _companySize.dispose();
    _industry.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CompanyRegisterCubit>(),
      child: BlocListener<CompanyRegisterCubit, CompanyRegisterState>(
        listener: (context, state) {
          if (state is CompanyRegisterFailure) {
            context.pop();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is CompanyRegisterLoading) {
            showLoadingDialog(context);
          }
        },
        child: CompanyRegisterView(
          formKey: _formKey,
          companyNameController: _companyNameController,
          fullNameController: _fullNameController,
          emailController: _emailController,
          passwordController: _passwordController,
          confirmPasswordController: _confirmPasswordController,
          companySize: _companySize,
          industry: _industry,
        ),
      ),
    );
  }
}

class CompanyRegisterView extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController companyNameController;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final ValueNotifier<EnumValue> companySize;
  final ValueNotifier<EnumValue> industry;

  const CompanyRegisterView({
    required this.formKey,
    required this.companyNameController,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.companySize,
    required this.industry,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.platinum,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(child: Container(color: AppColors.tiger)),
              Expanded(child: Container(color: AppColors.platinum)),
            ],
          ),
          Column(
            children: [
              gapH214,
              Expanded(
                child: Container(
                  padding: Paddings.paddingHorizontal20,
                  decoration: const BoxDecoration(
                    color: AppColors.platinum,
                    borderRadius: .only(
                      topLeft: .circular(30),
                      topRight: .circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: .spaceBetween,
                        crossAxisAlignment: .start,
                        children: [
                          gapH32,
                          CustomTextField(
                            title: 'company_register.company_name'.tr(),
                            validator: Validator.validateCompanyName,
                            controller: companyNameController,
                          ),
                          gapH20,
                          CustomDropdownButton(
                            title: 'company_register.industry'.tr(),
                            valueNotifier: industry,
                            items: IndustryType.values,
                          ),
                          gapH20,
                          CustomDropdownButton(
                            title: 'company_register.company_size'.tr(),
                            valueNotifier: companySize,
                            items: CompanySize.values,
                          ),
                          gapH20,
                          CustomTextField(
                            title: 'company_register.full_name'.tr(),
                            hintText: 'company_register.full_name_hint'.tr(),
                            validator: Validator.validateFullName,
                            controller: fullNameController,
                          ),
                          gapH20,
                          CustomTextField(
                            title: 'company_register.email'.tr(),
                            hintText: 'company_register.email_hint'.tr(),
                            validator: Validator.validateEmail,
                            controller: emailController,
                          ),
                          gapH20,
                          CustomTextField(
                            title: 'company_register.password'.tr(),
                            hintText: 'company_register.password_hint'.tr(),
                            obscureText: true,
                            validator: Validator.validateRegisterPassword,
                            controller: passwordController,
                          ),
                          gapH20,
                          CustomTextField(
                            title: 'company_register.confirm_password'.tr(),
                            obscureText: true,
                            validator: (value) =>
                                Validator.validateConfirmPassword(
                                  value,
                                  passwordController.text,
                                ),
                            controller: confirmPasswordController,
                          ),
                          gapH20,
                          Align(
                            alignment: Alignment.centerRight,
                            child: CustomButton(
                              text: 'company_register.sign_up_button'.tr(),
                              elevation: 4,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  BlocProvider.of<CompanyRegisterCubit>(
                                    context,
                                  ).register(
                                    name: companyNameController.text,
                                    industry: industry.value.key,
                                    size: companySize.value.value,
                                    contactName: fullNameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                            ),
                          ),
                          gapH32,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          HeaderWidget(
            subtitle: 'company_register.subtitle'.tr(),
            additionalText: 'company_register.additional_text'.tr(),
            color: Theme.of(context).colorScheme.surfaceContainer,
            headerType: HeaderType.convexOut,
          ),
        ],
      ),
    );
  }
}
