part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeIndexChangeEvent extends HomeEvent {
  final int index;

  const HomeIndexChangeEvent({required this.index});

  @override
  List<Object> get props => [index];
}

class HomeEnterPageEvent extends HomeEvent {
  final int index;

  const HomeEnterPageEvent({required this.index});

  @override
  List<Object> get props => [index];
}

class HomeLeavePageEvent extends HomeEvent {
  final int index;

  const HomeLeavePageEvent({required this.index});

  @override
  List<Object> get props => [index];
}

class HomeMiddlePageEvent extends HomeEvent {
  final int index;

  const HomeMiddlePageEvent({required this.index});

  @override
  List<Object> get props => [index];
}

class HomeDonePageEvent extends HomeEvent {}

class HomeShowBottomSheetEvent extends HomeEvent {}
