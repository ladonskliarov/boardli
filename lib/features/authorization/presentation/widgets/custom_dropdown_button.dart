import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_dimensions.dart';
import '../../../../core/style/app_icons.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../../core/style/app_themes.dart';
import '../constants/enums.dart';

class CustomDropdownButton extends StatelessWidget {
  final String title;
  final ValueNotifier<EnumValue> valueNotifier;
  final List<EnumValue> items;
  const CustomDropdownButton({
    required this.title,
    required this.valueNotifier,
    required this.items,
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
            color: AppColors.black.withValues(alpha: 0.9),
          ),
        ),
        gapH10,
        ValueListenableBuilder<EnumValue>(
          valueListenable: valueNotifier,
          builder: (context, state, child) => Container(
            padding: Paddings.paddingHorizontal20,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: .circular(20),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<EnumValue>(
                isExpanded: true,
                value: state,
                icon: SvgPicture.asset(AppIcons.arrowDown),
                dropdownColor: AppColors.white,
                style: TextStyle(
                  color: AppColors.gunMetal,
                  fontFamily: AppThemes.fontFamily,
                  fontSize: 16,
                ),
                borderRadius: .circular(20),
                items: items.map<DropdownMenuItem<EnumValue>>((EnumValue element) {
                  return DropdownMenuItem<EnumValue>(
                    value: element,
                    child: Text(element.value),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    valueNotifier.value = value;
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
