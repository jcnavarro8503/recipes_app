import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recipes_app/core/index.dart';
import 'package:recipes_app/features/index.dart';

import '../../../../helpers/json_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late RecipesLocalDataSourceImpl local;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    local = RecipesLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  const nextPageUrl =
      'https://api.edamam.com/api/recipes/v2?app_key=aac60a26b0fc428122518bd4a017ad1a&mealType=Breakfast&mealType=Dinner&mealType=Lunch&_cont=CHcVQBtNNQphDmgVQntAEX4BY0t3AwEVX3dHCjdBNQN0DQMOSzETBjYTMVR6VlcDF2ZDUGpHZlInVxFqX3cWQT1OcV9xBB8VADQWVhFCPwoxXVZEITQeVDcBaR4-SQ%3D%3D&type=public&app_id=4be3fd3e';
  final tRecipeListString =
      (json.decode(readJson('recipe_list.json')) as List).map((item) => json.encode(item)).toList();
  final tRecipeListModels = tRecipeListString
      .map<RecipeModel>((item) => RecipeModel.fromJson(json.decode(item)))
      .toList();
  final tRecipesData = RecipeResponseModel(recipes: tRecipeListModels, nextUrl: nextPageUrl);

  group('getLastRecipesCached', () {
    test(
      'shoult return the lates cached recipes from shared preferences if exist cached recipes',
      () async {
        // arrange
        when(mockSharedPreferences.getStringList(any)).thenReturn(tRecipeListString);

        // act
        final result = await local.getLastRecipesCached();

        // assert
        verify(mockSharedPreferences.getStringList(cachedRecipes));
        expect(result, equals(tRecipeListModels));
      },
    );

    test(
      'shoult return a Cache Exception from shared preferences if not cached recipes data',
      () async {
        // arrange
        when(mockSharedPreferences.getStringList(any)).thenReturn(null);

        // act
        final call = local.getLastRecipesCached;

        // assert
        expect(() => call(), throwsA(const TypeMatcher<CacheFailure>()));
      },
    );
  });

  group('cacheRecipes', () {
    test(
      'shoult store the recipes from API into shared preferences',
      () async {
        // act
        local.cacheRecipes(tRecipesData);

        // assert
        final expedtedStrList =
            tRecipeListModels.map<String>((item) => json.encode(item.toJson())).toList();
        verify(mockSharedPreferences.setStringList(cachedRecipes, expedtedStrList));
      },
    );
  });
}
