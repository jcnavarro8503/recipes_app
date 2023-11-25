import 'package:equatable/equatable.dart';
import 'package:recipes_app/features/index.dart';

class RecipeResponseEntity extends Equatable {
  final List<RecipeEntity> recipes;
  final String nextUrl;

  const RecipeResponseEntity({
    required this.recipes,
    required this.nextUrl,
  });

  @override
  List<Object?> get props => [
        recipes,
        nextUrl,
      ];
}
