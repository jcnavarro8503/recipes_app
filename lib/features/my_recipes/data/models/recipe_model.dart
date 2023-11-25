import 'package:recipes_app/features/index.dart';

class RecipeModel extends RecipeEntity {
  const RecipeModel({
    required String uri,
    required String label,
    required String image,
    required String url,
    required List<String> ingredientLines,
    required List<IngredientModel> ingredients,
    required num totalTime,
    required List<String> cuisineType,
    required List<String> mealType,
    required List<String> dishType,
  }) : super(
          uri: uri,
          label: label,
          image: image,
          url: url,
          ingredientLines: ingredientLines,
          ingredients: ingredients,
          totalTime: totalTime,
          cuisineType: cuisineType,
          mealType: mealType,
          dishType: dishType,
        );

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      uri: json['uri'] ?? '',
      label: json['label'] ?? '',
      image: json['image'] ?? '',
      url: json['url'] ?? '',
      ingredientLines: json['ingredientLines'] != null
          ? (json['ingredientLines'] as List).map<String>((item) => item).toList()
          : [],
      ingredients: json['ingredients'] != null
          ? (json['ingredients'] as List)
              .map<IngredientModel>((item) => IngredientModel.fromJson(item))
              .toList()
          : [],
      totalTime: json['totalTime'] != null ? json['totalTime'] as num : 0,
      cuisineType: json['cuisineType'] != null
          ? (json['cuisineType'] as List).map<String>((item) => item).toList()
          : [],
      mealType: json['mealType'] != null
          ? (json['mealType'] as List).map<String>((item) => item).toList()
          : [],
      dishType: json['dishType'] != null
          ? (json['dishType'] as List).map<String>((item) => item).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uri": uri,
      "label": label,
      "image": image,
      "url": url,
      "ingredientLines": ingredientLines,
      "ingredients": ingredients.map((item) => (item as IngredientModel).toJson()).toList(),
      "totalTime": totalTime,
      "cuisineType": cuisineType,
      "mealType": mealType,
      "dishType": dishType,
    };
  }

  RecipeEntity toEntity() {
    return RecipeEntity(
      uri: uri,
      label: label,
      image: image,
      url: url,
      ingredientLines: ingredientLines,
      ingredients: ingredients.map((item) => (item as IngredientModel).toEntity()).toList(),
      totalTime: totalTime,
      cuisineType: cuisineType,
      mealType: mealType,
      dishType: dishType,
    );
  }
}
