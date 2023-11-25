part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final Themes theme;
  final ThemeData themeData;

  const ThemeState({required this.theme, required this.themeData});

  ThemeState copyWith({
    Themes? theme,
    ThemeData? themeData,
  }) {
    return ThemeState(
      theme: theme ?? this.theme,
      themeData: themeData ?? this.themeData,
    );
  }

  @override
  List<Object> get props => [theme, themeData];
}
