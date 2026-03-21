import 'package:flutter/material.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_dimensions.dart';
import 'custom_bottom_bar_item.dart';

class CustomBottomBar extends StatelessWidget {
  final List<CustomBottomBarItem> bottomBarItems;
  const CustomBottomBar({required this.bottomBarItems, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.zero,
        child: Container(
          height: 80,
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 12),
          padding: Paddings.paddingHorizontal6,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(40.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: bottomBarItems,
          ),
        ),
      ),
    );
  }
}
