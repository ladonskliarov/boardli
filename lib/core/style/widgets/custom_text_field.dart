import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../app_colors.dart';
import '../app_dimensions.dart';
import '../app_text_styles.dart';

class CustomTextField extends StatefulWidget {
  final String title;
  final Color? titleColor, errorColor;
  final String? hintText;
  final bool obscureText;
  final FormFieldValidator<String> validator;
  final TextEditingController controller;
  const CustomTextField({
    required this.title,
    required this.validator,
    required this.controller,
    this.obscureText = false,
    this.titleColor,
    this.errorColor,
    this.hintText,
    super.key,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  String _getIcon() {
    if (_isObscured) {
      return 'assets/icons/eye-off.svg';
    } else {
      return 'assets/icons/eye.svg';
    }
  }

  void changeVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          widget.title,
          style: AppTextStyles.light20.copyWith(
            color: widget.titleColor ?? AppColors.black.withValues(alpha: 0.9),
          ),
        ),
        gapH12,
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          autovalidateMode: .onUnfocus,
          style: const TextStyle(color: AppColors.gunMetal),
          cursorColor: AppColors.gunMetal,
          obscureText: _isObscured,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            hintText: widget.hintText,
            errorStyle: TextStyle(
              color: widget.errorColor ?? AppColors.gunMetal,
            ),
            hintStyle: TextStyle(
              color: AppColors.grey.withValues(alpha: 0.8),
              fontSize: 16,
            ),
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
            suffixIcon: widget.obscureText
                ? IconButton(
                    onPressed: () => changeVisibility(),
                    icon: SvgPicture.asset(_getIcon()),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
