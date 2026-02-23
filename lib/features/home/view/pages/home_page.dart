import 'package:data_caching/core/dependency_injection/di.dart';
import 'package:data_caching/core/helper/connection_helper.dart';
import 'package:data_caching/core/pages/error_page.dart';
import 'package:data_caching/core/utils/custom_alert.dart';
import 'package:data_caching/core/utils/custom_loading_widget.dart';
import 'package:data_caching/features/home/data/models/product_model.dart';
import 'package:data_caching/features/home/view/bloc/home_blocs/home_bloc.dart';
import 'package:data_caching/features/home/view/bloc/home_blocs/product_status.dart';
import 'package:data_caching/features/home/view/widget/bnb.dart';
import 'package:data_caching/features/home/view/widget/home_single_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

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
        // to make bnb background transparent
        extendBody: true,
        appBar: AppBar(
          title: const Text('Home Page'),
          centerTitle: true,
        ),

        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: BlocConsumer<HomeBloc, HomeState>(

            // show alert wether data is from server or local cache
            listener: (context, state) async {
              if (state.homeProductStatus is HomeProductStatusCompleted) {

                final bool isConnected = 
                  await di<InternetConnectionHelper>().checkInternetConnection();

                final String message = isConnected
                    ? 'From Server' : 'From Local Cache';

                CustomAlert.show(context, message);
              }
            },
            
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

                return CommonErrorPage(
                  isForNetwork: true, 
                  description: errorMessage, 
                  onRetry: () {
                    context.read<HomeBloc>().add(const HomeCallProductsEvent());
                  }
                );
              }

              // completed state
              if (state.homeProductStatus is HomeProductStatusCompleted) {
                final HomeProductStatusCompleted completedState =
                    state.homeProductStatus as HomeProductStatusCompleted;

                final List<Product> products = completedState.products;

                return LiquidPullToRefresh(
                  backgroundColor: theme.scaffoldBackgroundColor,
                  color: theme.primaryColor,
                  showChildOpacityTransition: true,
                  onRefresh: () async {
                    // without context extension
                    BlocProvider.of<HomeBloc>(context)
                      .add(const HomeCallProductsEvent());

                    // with context extension
                    context.read<HomeBloc>()
                      .add(const HomeCallProductsEvent());

                    
                  },
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return HomeSingeListItem(
                        current: products[index],
                      );
                    },
                  ),
                );
              }


              else {
                return Container();
              }
            
            },

            listenWhen: (previous, current) {
              return previous.homeProductStatus != current.homeProductStatus;
            },

            buildWhen: (previous, current) {
              // rebuild only when homeProductStatus changes
              return previous.homeProductStatus != current.homeProductStatus;
            },

          ),
  
        ),  

        bottomNavigationBar: const BNB(),
        
    );
  
        
  } 
}
