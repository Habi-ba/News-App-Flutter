import 'package:flutter/material.dart';
import 'package:news/api/model/sources/source.dart';
import 'package:news/ui/home/category_details/source/source_name.dart';

class SourceWidget extends StatefulWidget {
  final List<Source> sourcesList;

  SourceWidget({super.key, required this.sourcesList});

  @override
  State<SourceWidget> createState() => _SourceWidgetState();
}

class _SourceWidgetState extends State<SourceWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.sourcesList.length,
      child: Column(
        children: [
          TabBar(
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            dividerColor: Colors.transparent,
            indicatorColor: Theme.of(context).dividerColor,
            tabs:
                widget.sourcesList.map((source) {
                  return SourceName(
                    source: source,
                    isSelected:
                        selectedIndex == widget.sourcesList.indexOf(source),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
