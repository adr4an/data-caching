part of 'home_bloc.dart';

@immutable
class HomeState extends Equatable {
  final HomeProductStatus homeProductStatus;

  const HomeState({
    required this.homeProductStatus
  });
  
  @override
  List<Object> get props => [homeProductStatus];

  // for updating the state
  HomeState copyWith({HomeProductStatus? homeProductStatus}) {
    return HomeState(
      homeProductStatus: homeProductStatus ?? this.homeProductStatus,
    );
  }

}