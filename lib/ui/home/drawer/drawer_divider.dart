import 'package:flutter/material.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/size_utils.dart';

class DrawerDivider extends StatelessWidget {
  const DrawerDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Divider(
        color: AppColors.white,
        thickness: 1,
        indent: context.scaleWidth(10),
        endIndent: context.scaleWidth(10),
      ),
    );
  }
}
