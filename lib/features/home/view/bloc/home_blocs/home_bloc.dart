import 'package:bloc/bloc.dart';
import 'package:data_caching/core/resources/data_state.dart';
import 'package:data_caching/features/home/logic/home_repository.dart';
import 'package:data_caching/features/home/data/models/product_model.dart';
import 'package:data_caching/features/home/view/bloc/home_blocs/product_status.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _homeRepository;

  HomeBloc(this._homeRepository)
      : super(HomeState(homeProductStatus: HomeProductStatusInit())) {
    on<HomeCallProductsEvent>(_onHomeCallProductsEvent);
  }

  Future<void> _onHomeCallProductsEvent(
      HomeCallProductsEvent event, 
      Emitter<HomeState> emit) async {
    // loading state
    emit(state.copyWith(
      homeProductStatus: HomeProductStatusLoading()
    ));

    // get data DataSuccess or DataError
    final DataState<Product?> dataState =
        await _homeRepository.fetchProducts();

    // success state with non-null product
    if (dataState is DataSuccess<Product?>) {
      emit(state.copyWith(
          homeProductStatus:
              HomeProductStatusCompleted(dataState.data!)
      ));
    }

    // failed state or null data
    else {
      // determine if error or no data message
      final String message = (dataState is DataError)
          ? dataState.error ?? 'Unknown error'
          : 'No product available';

      emit(state.copyWith(
          homeProductStatus: HomeProductStatusError(message)
      ));
    }
  }
}
