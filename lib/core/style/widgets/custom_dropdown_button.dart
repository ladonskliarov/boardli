import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_colors.dart';
import '../app_dimensions.dart';
import '../app_icons.dart';
import '../app_text_styles.dart';
import '../app_themes.dart';
import '../../../features/auth/presentation/constants/enums.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final ValueNotifier<T> valueNotifier;
  final List<T> items;
  const CustomDropdownButton({
    required this.title,
    required this.valueNotifier,
    required this.items,
    this.titleColor,
    super.key,
  });

  String _getDisplayText(T element) {
    if (element is EnumValue) {
      return element.value;
    }
    return element.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          title,
          style: AppTextStyles.light20.copyWith(
            color: titleColor ?? AppColors.gunMetal,
          ),
        ),
        gapH10,
        ValueListenableBuilder<T>(
          valueListenable: valueNotifier,
          builder: (context, state, child) => Container(
            padding: Paddings.paddingHorizontal20,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: .circular(20),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
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
                items: items.map<DropdownMenuItem<T>>((T element) {
                  return DropdownMenuItem<T>(
                    value: element,
                    child: Text(_getDisplayText(element)),
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
