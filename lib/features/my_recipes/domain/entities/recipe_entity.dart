import 'package:equatable/equatable.dart';
import 'package:recipes_app/features/index.dart';

class RecipeEntity extends Equatable {
  final String uri;
  final String label;
  final String image;
  final String url;
  final List<String> ingredientLines;
  final List<IngredientEntity> ingredients;
  final num totalTime;
  final List<String> cuisineType;
  final List<String> mealType;
  final List<String> dishType;

  const RecipeEntity({
    required this.uri,
    required this.label,
    required this.image,
    required this.url,
    required this.ingredientLines,
    required this.ingredients,
    required this.totalTime,
    required this.cuisineType,
    required this.mealType,
    required this.dishType,
  });

  factory RecipeEntity.empty() {
    return const RecipeEntity(
      uri: '',
      label: '',
      image: '',
      url: '',
      ingredientLines: [],
      ingredients: [],
      totalTime: 0,
      cuisineType: [],
      mealType: [],
      dishType: [],
    );
  }

  @override
  List<Object?> get props => [
        uri,
        label,
        image,
        url,
        ingredientLines,
        ingredients,
        totalTime,
        cuisineType,
        mealType,
        dishType,
      ];
}
