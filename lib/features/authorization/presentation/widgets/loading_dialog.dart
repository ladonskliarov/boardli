import 'package:flutter/material.dart';

import '../../../../core/style/app_colors.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      // ignore: deprecated_member_use
      return WillPopScope(
        onWillPop: () async => false, 
        child: const Center(
          child: CircularProgressIndicator(
            color: AppColors.sandyBrown,
          ),
        ),
      );
    },
  );
}