import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'localization_event.dart';
part 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc() : super(const LocalizationState(locale: Locale('en', ''))) {
    on<LocalizationEvent>((event, emit) async {
      if (event is LocalizationChangeEvent) {
        await onLocalizationChangeEvent(event, emit);
      }
    });
  }

  Future<void> onLocalizationChangeEvent(
      LocalizationChangeEvent event, Emitter<LocalizationState> emit) async {
    debugPrint('Localization changes');

    emit(state.copyWith(locale: event.locale));
  }
}
