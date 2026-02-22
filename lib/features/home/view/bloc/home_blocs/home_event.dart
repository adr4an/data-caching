part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

// for loading products for home screen
class HomeCallProductsEvent extends HomeEvent {
  const HomeCallProductsEvent();

  @override
  List<Object> get props => [];
}