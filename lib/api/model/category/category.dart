import 'package:flutter/cupertino.dart';
import 'package:news/utils/app_images.dart';
import 'package:news/utils/themed_image.dart';

class ApiCategory {
  String id;
  String title;
  Widget image;
  final CategoryTitlePosition alignment;

  ApiCategory({
    required this.title,
    required this.id,
    required this.image,
    required this.alignment,
  });

  static List<ApiCategory> getCategoriesList() {
    //business entertainment general health science sports technology
    return [
      ApiCategory(
        title: 'General',
        id: 'general',
        image: ThemedImage(
          lightImage: AppImages.generalLight,
          darkImage: AppImages.generalDark,
        ),
        alignment: CategoryTitlePosition.start,
      ),
      ApiCategory(
        title: 'Business',
        id: 'business',
        image: ThemedImage(
          lightImage: AppImages.businessLight,
          darkImage: AppImages.businessDark,
        ),
        alignment: CategoryTitlePosition.end,
      ),
      ApiCategory(
        title: 'Sports',
        id: 'sports',
        image: ThemedImage(
          lightImage: AppImages.sportLight,
          darkImage: AppImages.sportDark,
        ),
        alignment: CategoryTitlePosition.start,
      ),
      ApiCategory(
        title: 'Technology',
        id: 'technology',
        image: ThemedImage(
          lightImage: AppImages.technologyLight,
          darkImage: AppImages.technologyDark,
        ),
        alignment: CategoryTitlePosition.end,
      ),
      ApiCategory(
        title: 'Entertainment',
        id: 'entertainment',
        image: ThemedImage(
          lightImage: AppImages.entertainmentLight,
          darkImage: AppImages.entertainmentDark,
        ),
        alignment: CategoryTitlePosition.start,
      ),

      ApiCategory(
        title: 'Health',
        id: 'health',
        image: ThemedImage(
          lightImage: AppImages.healthLight,
          darkImage: AppImages.healthDark,
        ),
        alignment: CategoryTitlePosition.end,
      ),
      ApiCategory(
        title: 'Science',
        id: 'science',
        image: ThemedImage(
          lightImage: AppImages.scienceLight,
          darkImage: AppImages.scienceDark,
        ),
        alignment: CategoryTitlePosition.start,
      ),
    ];
  }
}

enum CategoryTitlePosition { start, end }
