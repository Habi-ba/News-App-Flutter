import 'package:flutter/material.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/app_styles.dart';
import 'package:news/utils/size_utils.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({super.key, required this.iconName, required this.text});

  final String iconName;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.scaleWidth(16),
        vertical: context.scaleHeight(16),
      ),
      child: Row(
        spacing: context.scaleWidth(10),
        children: [
          Image.asset(iconName, color: AppColors.white),
          Text(text, style: AppStyles.bold20White),
        ],
      ),
    );
  }
}
