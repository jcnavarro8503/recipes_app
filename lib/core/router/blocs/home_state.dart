part of 'home_bloc.dart';

enum HomeStateStatus { enterPage, middlePage, donePage, leavePage, showBottomSheet }

class HomeState extends Equatable {
  final HomeStateStatus status;
  final int index;

  const HomeState({required this.status, required this.index});

  HomeState copyWith({
    HomeStateStatus? status,
    int? index,
  }) {
    return HomeState(
      status: status ?? this.status,
      index: index ?? this.index,
    );
  }

  @override
  List<Object> get props => [status, index];
}
