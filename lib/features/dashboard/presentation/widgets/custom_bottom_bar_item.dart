import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_dimensions.dart';

class CustomBottomBarItem extends StatelessWidget {
  final String iconPath;
  final bool isSelected;
  final VoidCallback onTap;
  const CustomBottomBarItem({
    required this.iconPath,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        height: 70,
        width: 70,
        padding: Paddings.paddingAll16,
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.sandyBrown : null,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          iconPath,
          colorFilter: ColorFilter.mode(
            isSelected ? AppColors.white : AppColors.grey,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
