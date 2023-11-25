import 'dart:convert';

import 'package:recipes_app/core/index.dart';
import 'package:recipes_app/features/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class RecipesLocalDataSource {
  /// Get the last cached [RecipeModel] list
  /// gotten with internet connection
  ///
  /// Throw a [CacheException] for all errors
  Future<RecipeResponseModel> getLastRecipesCached();

  /// Set the last cached [RecipeModel] list
  /// gotten with internet connection
  ///
  /// Throw a [CacheException] for all errors
  Future<void> cacheRecipes(RecipeResponseModel data);
}

const cachedRecipes = 'cachedRecipes';
const cachedNextUrl = 'cachedNextUrl';

class RecipesLocalDataSourceImpl implements RecipesLocalDataSource {
  final SharedPreferences sharedPreferences;

  RecipesLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> cacheRecipes(RecipeResponseModel data) async {
    final strList = (data.recipes as List<RecipeModel>)
        .map<String>((item) => json.encode(item.toJson()))
        .toList();

    await sharedPreferences.setString(cachedNextUrl, data.nextUrl);
    return await sharedPreferences.setStringList(cachedRecipes, strList);
  }

  @override
  Future<RecipeResponseModel> getLastRecipesCached() {
    final jsonStringNextUrl = sharedPreferences.getString(cachedNextUrl);
    final jsonStringList = sharedPreferences.getStringList(cachedRecipes);

    if (jsonStringList != null) {
      final list = jsonStringList.map((item) => RecipeModel.fromJson(json.decode(item))).toList();
      return Future.value(
        RecipeResponseModel(recipes: list, nextUrl: jsonStringNextUrl ?? ''),
      );
    } else {
      throw CacheFailure();
    }
  }
}
