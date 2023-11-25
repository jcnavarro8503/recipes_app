import 'package:recipes_app/features/index.dart';

class RecipeResponseModel extends RecipeResponseEntity {
  const RecipeResponseModel({
    required List<RecipeModel> recipes,
    required String nextUrl,
  }) : super(
          recipes: recipes,
          nextUrl: nextUrl,
        );

  factory RecipeResponseModel.fromJson(Map<String, dynamic> json) {
    return RecipeResponseModel(
      recipes: json['hits'] != null
          ? (json['hits'] as List)
              .map<RecipeModel>((item) => RecipeModel.fromJson(item['recipe']))
              .toList()
          : [],
      nextUrl: json['_links']['next']['href'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "recipes": (recipes as List<RecipeModel>).map((item) => item.toJson()).toList(),
      "nextUrl": nextUrl,
    };
  }

  RecipeResponseEntity toEntity() {
    return RecipeResponseEntity(
      recipes: (recipes as List<RecipeModel>).map((item) => item.toEntity()).toList(),
      nextUrl: nextUrl,
    );
  }
}
