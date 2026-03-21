import 'package:flutter/material.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_dimensions.dart';
import '../../../../core/style/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final Color? errorColor;
  final String? hintText;
  final FormFieldValidator<String> validator;
  final TextEditingController controller;
  const CustomTextField({
    required this.title,
    required this.validator,
    required this.controller,
    this.titleColor,
    this.errorColor,
    this.hintText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          title,
          style: AppTextStyles.light20.copyWith(
            color: titleColor ?? AppColors.black.withValues(alpha: 0.9),
          ),
        ),
        gapH12,
        TextFormField(
          controller: controller,
          validator: validator,
          autovalidateMode: .onUnfocus,
          style: const TextStyle(color: AppColors.gunMetal),
          cursorColor: AppColors.gunMetal,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            hintText: hintText,
            errorStyle: TextStyle(color: errorColor ?? AppColors.gunMetal),
            hintStyle: TextStyle(color: AppColors.grey.withValues(alpha: 0.8), fontSize: 16),
            contentPadding: const .symmetric(horizontal: 20, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: .circular(20),
              borderSide: .none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: .circular(20),
              borderSide: .none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: .circular(20),
              borderSide: .none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: .circular(20),
              borderSide: const BorderSide(color: AppColors.tiger, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
