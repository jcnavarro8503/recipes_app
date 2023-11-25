part of 'localization_bloc.dart';

abstract class LocalizationEvent extends Equatable {
  const LocalizationEvent();

  @override
  List<Object> get props => [];
}

class LocalizationChangeEvent extends LocalizationEvent {
  final Locale locale;

  const LocalizationChangeEvent({required this.locale});

  @override
  List<Object> get props => [locale];
}
