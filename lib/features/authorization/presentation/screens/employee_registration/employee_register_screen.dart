import 'package:boardli/core/style/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/di/injection_container.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_dimensions.dart';
import '../../../../../core/util/validator.dart';
import '../../constants/enums.dart';
import '../../cubits/employee_register_cubit/employee_register_cubit.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_dropdown_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/header.dart';
import '../../widgets/loading_dialog.dart';

class EmployeeRegisterScreen extends StatefulWidget {
  const EmployeeRegisterScreen({super.key});

  @override
  State<EmployeeRegisterScreen> createState() => _EmployeeRegisterScreenState();
}

class _EmployeeRegisterScreenState extends State<EmployeeRegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<Gender> _gender = ValueNotifier<Gender>(Gender.other);
  final TextEditingController _inviteKeyController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _hobbiesController = TextEditingController();
  final TextEditingController _favoriteAnimalsController = TextEditingController();

  @override
  void dispose() {
    _inviteKeyController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _hobbiesController.dispose();
    _favoriteAnimalsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<EmployeeRegisterCubit>(),
      child: BlocListener<EmployeeRegisterCubit, EmployeeRegisterState>(
        listener: (context, state) {
          if (state is EmployeeRegisterSuccess) {
            context.pop();
          } else if (state is EmployeeRegisterFailure) {
            context.pop();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is EmployeeRegisterLoading) {
            showLoadingDialog(context);
          }
        },
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColors.tiger,
            body: Stack(
              children: [
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
                                  title: 'Invite key',
                                  validator: Validator.validateInviteKey,
                                  controller: _inviteKeyController,
                                ),
                                gapH20,
                                CustomTextField(
                                  title: 'Create password',
                                  hintText: 'Min. 8 characters',
                                  validator: Validator.validateRegisterPassword,
                                  controller: _passwordController,
                                ),
                                gapH20,
                                CustomTextField(
                                  title: 'Confirm password',
                                  validator: (value) =>
                                      Validator.validateConfirmPassword(value, _passwordController.text),
                                  controller: _confirmPasswordController,
                                ),
                                gapH20,
                                CustomDropdownButton(
                                  title: 'Your gender',
                                  valueNotifier: _gender,
                                  items: Gender.values,
                                ),
                                gapH20,
                                CustomTextField(
                                  title: 'Your hobbie(s)',
                                  hintText: 'CrossFit, Reading',
                                  validator: Validator.validateHobby,
                                  controller: _hobbiesController,
                                ),
                                gapH20,
                                CustomTextField(
                                  title: 'Favorite animal(s)',
                                  hintText: 'Capybara, Cat',
                                  validator: Validator.validateAnimal,
                                  controller: _favoriteAnimalsController,
                                ),
                                gapH20,
                                Align(
                                  alignment: .centerRight,
                                  child: CustomButton(
                                    text: 'Sign up',
                                    elevation: 4,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        BlocProvider.of<EmployeeRegisterCubit>(context).register(
                                          inviteKey: _inviteKeyController.text,
                                          password: _passwordController.text,
                                          gender: _gender.value.value,
                                          hobbies: _hobbiesController.text,
                                          favoriteAnimals: _favoriteAnimalsController.text,
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
                  subtitle: 'Your first day, guided by AI',
                  subtitleStyle: AppTextStyles.regular18,
                  color: AppColors.gunMetal,
                  headerType: .convexOut,
                ),
              ],
            ),
          );
        }
      ),
    ),);
  }
}
