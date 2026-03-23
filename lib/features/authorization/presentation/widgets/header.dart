import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_dimensions.dart';
import '../../../../core/style/app_text_styles.dart';

enum HeaderType { convexIn, convexOut }

class HeaderWidget extends StatelessWidget {
  final String? subtitle, additionalText;
  final HeaderType headerType;
  final Color color;
  final Color? textColor;
  final TextStyle? subtitleStyle;
  final bool isShadow;
  const HeaderWidget({
    this.subtitle,
    this.subtitleStyle,
    this.additionalText,
    this.headerType = HeaderType.convexIn,
    this.color = AppColors.tiger,
    this.textColor,
    this.isShadow = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Stack(
        alignment: .center,
        children: [
          CustomPaint(
            size: Size(double.infinity, 230),
            painter: HeaderPainter(
              headerType: headerType,
              color: color,
              isShadow: isShadow,
            ),
          ),
          Column(
            mainAxisAlignment: .start,
            crossAxisAlignment: .center,
            children: [
              AppBar(
                centerTitle: true,
                iconTheme: IconThemeData(color: textColor ?? Theme.of(context).colorScheme.onSurface),
                foregroundColor: Theme.of(context).colorScheme.onSurface,
                surfaceTintColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                title: Text('Boardli', style: AppTextStyles.title.copyWith(color: textColor ?? Theme.of(context).colorScheme.onSurface)),
              ),
              if (subtitle != null)
                Text(
                  subtitle!.tr(),
                  style: subtitleStyle ?? AppTextStyles.subtitle.copyWith(color: textColor ?? Theme.of(context).colorScheme.onSurface),
                ),
              if (additionalText != null)
                Padding(
                  padding: Paddings.paddingOnlyTop4,
                  child: Text(additionalText!.tr(), style: AppTextStyles.light16.copyWith(color: textColor ?? Theme.of(context).colorScheme.onSurface)),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class HeaderPainter extends CustomPainter {
  final HeaderType headerType;
  final Color color;
  final bool isShadow;

  HeaderPainter({
    required this.headerType,
    required this.color,
    required this.isShadow,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final orangePath = Path();

    late final double startY;
    late final double controlY;

    if (headerType == HeaderType.convexIn) {
      startY = 230;
      controlY = 90;
    } else {
      startY = 130;
      controlY = 260;
    }

    orangePath.lineTo(0, startY);
    orangePath.quadraticBezierTo(size.width / 2, controlY, size.width, startY);
    orangePath.lineTo(size.width, 0);
    orangePath.close();

    if (isShadow) {
      final shadowPaint = Paint()
        ..color = AppColors.black.withValues(alpha: 0.35)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

      canvas.drawPath(orangePath.shift(const Offset(0, 4)), shadowPaint);
    }

    final orangePaint = Paint()..color = color;
    canvas.drawPath(orangePath, orangePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
