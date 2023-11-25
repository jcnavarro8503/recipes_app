import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:recipes_app/core/index.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(theme: Themes.light, themeData: themesData[Themes.light]!)) {
    on<ThemeEvent>((event, emit) async {
      if (event is ThemeChangeEvent) {
        await onThemeChangeEvent(event, emit);
      }
    });
  }

  Future<void> onThemeChangeEvent(ThemeChangeEvent event, Emitter<ThemeState> emit) async {
    debugPrint('theme changes');

    emit(state.copyWith(
      theme: event.theme,
      themeData: themesData[event.theme],
    ));
  }
}
