import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState(status: HomeStateStatus.donePage, index: 0)) {
    on<HomeEvent>(
      (event, emit) async {
        if (event is HomeIndexChangeEvent) {
          await onHomeIndexChangeEvent(event, emit);
        } else if (event is HomeEnterPageEvent) {
          await onHomeEnterPageEvent(event, emit);
        } else if (event is HomeMiddlePageEvent) {
          await onHomeMiddlePageEvent(event, emit);
        } else if (event is HomeDonePageEvent) {
          await onHomeDonePageEvent(event, emit);
        } else if (event is HomeLeavePageEvent) {
          await onHomeLeavePageEvent(event, emit);
        } else if (event is HomeShowBottomSheetEvent) {
          await onHomeShowBottomSheetEvent(event, emit);
        }
      },
      transformer: sequential(),
    );
  }

  Future<void> onHomeIndexChangeEvent(HomeIndexChangeEvent event, Emitter<HomeState> emit) async {
    debugPrint('home index change from (${state.index}) to (${event.index})');

    add(HomeLeavePageEvent(index: event.index));
  }

  Future<void> onHomeEnterPageEvent(HomeEnterPageEvent event, Emitter<HomeState> emit) async {
    debugPrint('home enter page (${event.index})...');

    emit(state.copyWith(index: event.index, status: HomeStateStatus.enterPage));
    // Future.delayed(
    //   const Duration(milliseconds: 700),
    //   () => add(HomeDonePageEvent()),
    // );
  }

  Future<void> onHomeMiddlePageEvent(HomeMiddlePageEvent event, Emitter<HomeState> emit) async {
    debugPrint('home middle page ...');

    emit(state.copyWith(status: HomeStateStatus.middlePage));
    Future.delayed(
      const Duration(milliseconds: 100),
      () => add(HomeEnterPageEvent(index: event.index)),
    );
  }

  Future<void> onHomeDonePageEvent(HomeDonePageEvent event, Emitter<HomeState> emit) async {
    debugPrint('home done page ...');

    emit(state.copyWith(status: HomeStateStatus.donePage));
  }

  Future<void> onHomeLeavePageEvent(HomeLeavePageEvent event, Emitter<HomeState> emit) async {
    debugPrint('home leave page (${state.index}) ...');

    emit(state.copyWith(status: HomeStateStatus.leavePage));
    Future.delayed(
      const Duration(milliseconds: 700),
      () => add(HomeMiddlePageEvent(index: event.index)),
    );
  }

  Future<void> onHomeShowBottomSheetEvent(
      HomeShowBottomSheetEvent event, Emitter<HomeState> emit) async {
    debugPrint('home show bottom sheet ...');

    emit(state.copyWith(status: HomeStateStatus.showBottomSheet));
    Future.delayed(
      const Duration(milliseconds: 250),
      () => add(HomeDonePageEvent()),
    );
  }
}
