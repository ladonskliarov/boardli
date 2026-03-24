import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/theme_provider.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_dimensions.dart';
import 'custom_bottom_bar_item.dart';

class CustomBottomBar extends StatelessWidget {
  final List<CustomBottomBarItem> bottomBarItems;
  const CustomBottomBar({required this.bottomBarItems, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 80,
        margin: .only(left: 20, right: 20, bottom: 12),
        padding: Paddings.paddingHorizontal6,
        decoration: BoxDecoration(
          color: context.watch<ThemeProvider>().isDarkTheme ? AppColors.metal : AppColors.white,
          borderRadius: .circular(40.0),
        ),
        child: Row(
          mainAxisSize: .max,
          mainAxisAlignment: .spaceBetween,
          children: bottomBarItems,
        ),
      ),
    );
  }
}
