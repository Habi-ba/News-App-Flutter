import 'package:flutter/material.dart';
import 'package:news/api/model/category/category.dart';
import 'package:news/ui/home/category_details/source/source_view_model.dart';
import 'package:news/ui/home/category_details/source/source_widget.dart';
import 'package:news/ui/home/widget/main_error_widget.dart';
import 'package:news/ui/home/widget/main_loading_widget.dart';
import 'package:provider/provider.dart';

class CategoryDetails extends StatefulWidget {
  final ApiCategory category;

  const CategoryDetails({super.key, required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    viewModel.getSources(widget.category.id);
  }

  SourceViewModel viewModel = SourceViewModel();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => viewModel,
      child: Consumer<SourceViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return MainLoadingWidget();
          } else if (viewModel.errorMessage != null) {
            return MainErrorWidget(
              errorMesaage: viewModel.errorMessage!,
              onPressed: () {
                //todo:try again
                viewModel.getSources(widget.category.id);
                setState(() {});
              },
            );
          } else if (viewModel.sourcesList == null) {
            return MainLoadingWidget();
          } else {
            //todo:success
            return SourceWidget(sourcesList: viewModel.sourcesList ?? []);
          }
        },
      ),
      // FutureBuilder<SourceResponse>(
      //   future: ApiManager.getSources(widget.category.id),
      //   builder: (context, snapshot) {
      //     //todo:loading
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return MainLoadingWidget();
      //     }
      //     //todo: error
      //     else if (snapshot.hasError) {
      //       return MainErrorWidget(
      //         errorMesaage: snapshot.error.toString(),
      //         onPressed: () {
      //           //todo:try again
      //           ApiManager.getSources(widget.category.id);
      //           setState(() {});
      //         },
      //       );
      //     } else {
      //       //todo:server => response
      //       //todo:response=>success , error
      //       if (snapshot.data?.status != 'ok') {
      //         //todo:response => error
      //         return MainErrorWidget(
      //           errorMesaage: snapshot.data!.message!,
      //           onPressed: () {
      //             //todo:try again
      //             ApiManager.getSources(widget.category.id);
      //             setState(() {});
      //           },
      //         );
      //       } else {
      //         var sourceList = snapshot.data!.source ?? [];
      //         return SourceWidget(sourcesList: sourceList);
      //       }
      //     }
      //   },
      // ),
    );
  }
}
