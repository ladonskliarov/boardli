import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/features/authorization/presentation/widgets/loading_dialog.dart';
import '../../../../../core/di/injection_container.dart';
import '../../cubits/company_register_cubit/company_register_cubit.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_dimensions.dart';
import '../../../../../core/util/validator.dart';
import '../../constants/enums.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_dropdown_button.dart';
import '../../widgets/custom_text_field.dart';
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
        child: Builder(
          builder: (context) {
            return Scaffold(
              backgroundColor: AppColors.platinum,
              resizeToAvoidBottomInset: true,
              body: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Container(color: AppColors.tiger),
                      ),
                      Expanded(
                        child: Container(color: AppColors.platinum),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      gapH214,
                      Expanded(
                        child: Container(
                          padding: .symmetric(horizontal: 21),
                          decoration: BoxDecoration(
                            color: AppColors.platinum,
                            borderRadius: .only(
                              topLeft: .circular(30),
                              topRight: .circular(30),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: .spaceBetween,
                                crossAxisAlignment: .start,
                                children: [
                                  gapH32,
                                  CustomTextField(
                                    title: 'Company name',
                                    validator: Validator.validateCompanyName,
                                    controller: _companyNameController,
                                  ),
                                  gapH20,
                                  CustomDropdownButton(
                                    title: 'Industry',
                                    valueNotifier: _industry,
                                    items: IndustryType.values,
                                  ),
                                  gapH20,
                                  CustomDropdownButton(
                                    title: 'Company size',
                                    valueNotifier: _companySize,
                                    items: CompanySize.values,
                                  ),
                                  gapH20,
                                  CustomTextField(
                                    title: 'Your full name',
                                    hintText: 'Roman Shuhevich',
                                    validator: Validator.validateFullName,
                                    controller: _fullNameController,
                                  ),
                                  gapH20,
                                  CustomTextField(
                                    title: 'Work email',
                                    hintText: 'shuh@emapt.tech',
                                    validator: Validator.validateEmail,
                                    controller: _emailController,
                                  ),
                                  gapH20,
                                  CustomTextField(
                                    title: 'Password',
                                    hintText: 'Min. 8 charactercs',
                                    validator:
                                        Validator.validateRegisterPassword,
                                    controller: _passwordController,
                                  ),
                                  gapH20,
                                  CustomTextField(
                                    title: 'Confirm password',
                                    validator: (value) =>
                                        Validator.validateConfirmPassword(
                                          value,
                                          _passwordController.text,
                                        ),
                                    controller: _confirmPasswordController,
                                  ),
                                  gapH20,
                                  Align(
                                    alignment: .centerRight,
                                    child: CustomButton(
                                      text: 'Sign up',
                                      elevation: 4,
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          BlocProvider.of<CompanyRegisterCubit>(
                                            context,
                                          ).register(
                                            name: _companyNameController.text,
                                            industry: _industry.value.key,
                                            size: _companySize.value.value,
                                            contactName:
                                                _fullNameController.text,
                                            email: _emailController.text,
                                            password: _passwordController.text,
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
                    subtitle: 'Register your company',
                    additionalText: 'in 2 minutes',
                    color: AppColors.gunMetal,
                    headerType: .convexOut,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
