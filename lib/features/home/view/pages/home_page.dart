import 'package:data_caching/core/utils/custom_loading_widget.dart';
import 'package:data_caching/features/home/data/models/product_model.dart';
import 'package:data_caching/features/home/view/bloc/home_blocs/home_bloc.dart';
import 'package:data_caching/features/home/view/bloc/home_blocs/product_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ThemeData theme = Theme.of(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          centerTitle: true,
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: BlocConsumer<HomeBloc, HomeState>(
            builder: (context, state) {

              // loading state
              if (state.homeProductStatus is HomeProductStatusLoading) {
                return CustomLoading.showWithStyle(context);
              }

              // error state
              if (state.homeProductStatus is HomeProductStatusError) {
                final HomeProductStatusError errorState =
                    state.homeProductStatus as HomeProductStatusError;

                final String errorMessage = errorState.message;

                return Center(
                  child: Text(errorMessage),
                );
              }

              // completed state
              if (state.homeProductStatus is HomeProductStatusCompleted) {
                final HomeProductStatusCompleted completedState =
                    state.homeProductStatus as HomeProductStatusCompleted;

                final Product product = completedState.product;

                return Center(
                  child: Text(product.category),
                );
              } 


              else {
                return Container();
              }
            
            },

            listener: (context, state) {
            },

          ),
        ));
  }
}
