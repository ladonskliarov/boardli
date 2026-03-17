import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/router.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_dimensions.dart';
import '../../../../../core/style/app_text_styles.dart';
import '../../../../../core/util/extensions.dart';
import '../../widgets/header.dart';

class CompanyTariffsScreen extends StatelessWidget {
  const CompanyTariffsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tiger,
      body: Stack(
        children: [
          Column(
            children: [
              gapH214,
              Expanded(
                child: Container(
                  padding: .symmetric(horizontal: 21),
                  decoration: BoxDecoration(
                    color: AppColors.platinum,
                    borderRadius: .only(
                      topLeft: .circular(30),
                      topRight: .circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        gapH32,
                        TariffCard(),
                        gapH20,
                        TariffCard(),
                        gapH20,
                        TariffCard(),
                        gapH32,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          HeaderWidget(
            subtitle: 'Choose your plan',
            color: AppColors.gunMetal,
            headerType: .convexOut,
          ),
        ],
      ),
    );
  }
}

class TariffCard extends StatelessWidget {
  const TariffCard({super.key});

  void _onTap(BuildContext context) {
    context.pushNamed(AppPage.registerCompany.name);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 198.ph,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: .circular(20),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: .circular(20),
          onTap: () => _onTap(context),
          child: Ink(
            child: Padding(
              padding: Paddings.paddingAllM,
              child: Column(
                mainAxisAlignment: .spaceBetween,
                crossAxisAlignment: .start,
                children: [
                  Text('Standard plan', style: AppTextStyles.regular22),
                  Column(
                    mainAxisAlignment: .center,
                    crossAxisAlignment: .start,
                    children: [
                      Text('Employee daily requests:', style: AppTextStyles.light18),
                      Text('5000', style: AppTextStyles.light18),
                      Text('Daily document uploads:', style: AppTextStyles.light18),
                      Text('200', style: AppTextStyles.light18),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text('\$50 per month', style: AppTextStyles.medium20),
                      Text('Select', style: AppTextStyles.medium20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
