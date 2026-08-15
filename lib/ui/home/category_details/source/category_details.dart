import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/api/model/category/category.dart';
import 'package:news/api/model/sources/source_response.dart';
import 'package:news/ui/home/category_details/source/source_widget.dart';
import 'package:news/ui/home/widget/main_error_widget.dart';
import 'package:news/ui/home/widget/main_loading_widget.dart';

class CategoryDetails extends StatefulWidget {
  final ApiCategory category;

  const CategoryDetails({super.key, required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceResponse>(
      future: ApiManager.getSources(widget.category.id),
      builder: (context, snapshot) {
        //todo:loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MainLoadingWidget();
        }
        //todo: error
        else if (snapshot.hasError) {
          return MainErrorWidget(
            errorMesaage: snapshot.error.toString(),
            onPressed: () {
              //todo:try again
              ApiManager.getSources(widget.category.id);
              setState(() {});
            },
          );
        } else {
          //todo:server => response
          //todo:response=>success , error
          if (snapshot.data?.status != 'ok') {
            //todo:response => error
            return MainErrorWidget(
              errorMesaage: snapshot.data!.message!,
              onPressed: () {
                //todo:try again
                ApiManager.getSources(widget.category.id);
                setState(() {});
              },
            );
          } else {
            var sourceList = snapshot.data!.source ?? [];
            return SourceWidget(sourcesList: sourceList);
          }
        }
      },
    );
  }
}
