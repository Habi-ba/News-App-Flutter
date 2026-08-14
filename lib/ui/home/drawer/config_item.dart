import 'package:flutter/material.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/app_styles.dart';
import 'package:news/utils/size_utils.dart';

class ConfigItem extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ConfigItem({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.white, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: context.scaleWidth(16),
              ),
              child: Text(text, style: AppStyles.med20White),
            ),
            IconButton(
              onPressed: onPressed,
              icon: Icon(
                Icons.arrow_drop_down_rounded,
                size: 30,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
