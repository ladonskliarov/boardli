import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/theme_provider.dart';
import '../../../../core/style/app_colors.dart';

class CustomRefreshButton extends StatefulWidget {
  final Future<void> Function() onRefresh;

  const CustomRefreshButton({required this.onRefresh, super.key});

  @override
  State<CustomRefreshButton> createState() => _CustomRefreshButtonState();
}

class _CustomRefreshButtonState extends State<CustomRefreshButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkTheme;

    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      elevation: _isLoading ? 0 : 2,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: _isLoading
            ? null
            : () async {
                setState(() => _isLoading = true);

                await widget.onRefresh();

                if (mounted) {
                  setState(() => _isLoading = false);
                }
              },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isDark ? AppColors.metal : AppColors.white,
            shape: .circle,
            boxShadow: _isLoading
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: _isLoading
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: isDark ? AppColors.white : AppColors.metal,
                    strokeWidth: 2.5,
                  ),
                )
              : Icon(
                  Icons.refresh_rounded,
                  color: isDark ? AppColors.white : AppColors.metal,
                  size: 24,
                ),
        ),
      ),
    );
  }
}
