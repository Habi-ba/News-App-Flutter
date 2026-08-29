import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/api/model/category/category.dart';
import 'package:news/data/di/di.dart';
import 'package:news/ui/home/category_details/cubit/source_states.dart';
import 'package:news/ui/home/category_details/cubit/source_view_model.dart';
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
  SourceViewModel viewModel = SourceViewModel(
      sourceRepository: injectSourceRepository());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getSources(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocBuilder<SourceViewModel, SourceStates>(
        builder: (context, state) {
          if (state is SourceSuccessState) {
            return SourceWidget(sourcesList: state.sourcesList);
          } else if (state is SourceErrorState) {
            return MainErrorWidget(
              errorMesaage: state.errorMessage,
              onPressed: () {
                //todo:try again
                viewModel.getSources(widget.category.id);
              },
            );
          } else {
            return MainLoadingWidget();
          }
        },
      ),
    );

    //   FutureBuilder<SourceResponse>(
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
    // );
  }
}
