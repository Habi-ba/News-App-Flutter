import 'package:flutter/material.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/providers/app_language_provider.dart';
import 'package:news/providers/app_theme_provider.dart';
import 'package:news/ui/home/drawer/config_item.dart';
import 'package:news/ui/home/drawer/drawer_divider.dart';
import 'package:news/ui/home/drawer/drawer_item.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/app_images.dart';
import 'package:news/utils/app_styles.dart';
import 'package:news/utils/size_utils.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var langProvider = Provider.of<AppLanguageProvider>(context);

    return Column(
      children: [
        // Header
        Container(
          color: AppColors.white,
          height: context.scaleHeight(166),
          alignment: Alignment.center,
          child: Text(
            'News App',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        InkWell(
          onTap: () {
            //todo: go to home
          },
          child: DrawerItem(
            iconName: AppImages.home,
            text: AppLocalizations.of(context)!.goToHome,
          ),
        ),
        DrawerDivider(),

        DrawerItem(
          iconName: AppImages.roller,
          text: AppLocalizations.of(context)!.theme,
        ),
        ConfigItem(
          text:
              themeProvider.isDarkMode
                  ? AppLocalizations.of(context)!.dark
                  : AppLocalizations.of(context)!.light,
          onPressed: () {
            _showOptionsBottomSheet(
              context: context,
              title: AppLocalizations.of(context)!.theme,
              options: [
                AppLocalizations.of(context)!.light,
                AppLocalizations.of(context)!.dark,
              ],
              selectedOption:
                  themeProvider.isDarkMode
                      ? AppLocalizations.of(context)!.dark
                      : AppLocalizations.of(context)!.light,
              onSelect: (option) {
                if (option == AppLocalizations.of(context)!.dark) {
                  themeProvider.changeTheme(ThemeMode.dark);
                } else {
                  themeProvider.changeTheme(ThemeMode.light);
                }
              },
            );
          },
        ),
        SizedBox(height: context.scaleHeight(24)),
        DrawerDivider(),

        DrawerItem(
          iconName: AppImages.globe,
          text: AppLocalizations.of(context)!.language,
        ),
        ConfigItem(
          text:
              langProvider.locale.languageCode == 'en'
                  ? AppLocalizations.of(context)!.english
                  : AppLocalizations.of(context)!.arabic,
          onPressed: () {
            _showOptionsBottomSheet(
              context: context,
              title: AppLocalizations.of(context)!.language,
              options: [
                AppLocalizations.of(context)!.english,
                AppLocalizations.of(context)!.arabic,
              ],
              selectedOption:
                  langProvider.locale.languageCode == 'en'
                      ? AppLocalizations.of(context)!.english
                      : AppLocalizations.of(context)!.arabic,
              onSelect: (option) {
                if (option == AppLocalizations.of(context)!.english) {
                  langProvider.changeLanguage('en');
                } else {
                  langProvider.changeLanguage('ar');
                }
              },
            );
          },
        ),
      ],
    );
  }

  void _showOptionsBottomSheet({
    required BuildContext context,
    required String title,
    required List<String> options,
    required String selectedOption,
    required Function(String) onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children:
              options.map((option) {
                return ListTile(
                  title: Text(option, style: AppStyles.bold16black),
                  trailing: option == selectedOption ? Icon(Icons.check) : null,
                  onTap: () {
                    onSelect(option);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
        );
      },
    );
  }
}
