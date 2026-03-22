import 'package:flutter/material.dart';

import '../app_dimensions.dart';
import '../app_text_styles.dart';
import '../../util/extensions.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? textColor;
  final VoidCallback onPressed;
  final double? elevation;
  const CustomButton({required this.text, required this.onPressed, this.textColor, this.elevation, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(Sizes.p160.pw, Sizes.p60.ph),
        padding: EdgeInsets.symmetric(vertical: Sizes.p12.ph),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        side: BorderSide(color: Theme.of(context).colorScheme.onSurface),
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: .circular(20),
        ),
      ),
      onPressed: onPressed,
      child: Text(text, style: AppTextStyles.medium20.copyWith(color: textColor ?? Theme.of(context).colorScheme.onSurface)),
    );
  }
}
