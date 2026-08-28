import 'package:flutter/material.dart';
import 'package:news/api/model/sources/source.dart';
import 'package:news/ui/home/category_details/news/news_widget.dart';
import 'package:news/ui/home/category_details/source/source_name.dart';
import 'package:news/utils/size_utils.dart';

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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal:
        context.scaleWidth(16), vertical: context.scaleHeight(6)),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: context.scaleHeight(10)),
                child: TabBar(
                  onTap: (index) {
                    selectedIndex = index;
                    setState(() {});
                  },
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  dividerColor: Colors.transparent,
                  indicatorColor: Theme
                      .of(context)
                      .dividerColor,
                  tabs:
                  widget.sourcesList.map((source) {
                    return SourceName(
                      source: source,
                      isSelected:
                      selectedIndex == widget.sourcesList.indexOf(source),
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: context.scaleHeight(20)),
                    child: NewsWidget(
                        key: ValueKey(widget.sourcesList[selectedIndex].id),
                        source: widget.sourcesList[selectedIndex]),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
