import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../app_dimensions.dart';
import '../app_text_styles.dart';
import '../../util/extensions.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool? hasMinimumSize;
  final Color? textColor, backgroundColor;
  final VoidCallback onPressed;
  final double? elevation;
  const CustomButton({
    required this.text,
    required this.onPressed,
    this.textColor,
    this.hasMinimumSize,
    this.backgroundColor,
    this.elevation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: hasMinimumSize == true ? Size(Sizes.p160.pw, Sizes.p60.ph) : null,
        padding: EdgeInsets.symmetric(
          vertical: Sizes.p12.ph,
          horizontal: Sizes.p20.pw,
        ),
        overlayColor: AppColors.white.withValues(alpha: 0.1),
        backgroundColor:
            backgroundColor ?? AppColors.grey,
        side: BorderSide(color: AppColors.platinum),
        elevation: elevation,
        shape: RoundedRectangleBorder(borderRadius: .circular(20)),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: AppTextStyles.medium20.copyWith(
          color: textColor ?? AppColors.white,
        ),
      ),
    );
  }
}
