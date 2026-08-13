import 'package:flutter/material.dart';

import '../../../../api/model/sources/source.dart';

class SourceName extends StatelessWidget {
  final Source source;
  final bool isSelected;

  const SourceName({super.key, required this.source, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Text(
      source.name ?? '',
      style:
          isSelected
              ? theme.textTheme.displayMedium
              : theme.textTheme.bodySmall,
    );
  }
}
