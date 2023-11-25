import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:recipes_app/features/index.dart';

import '../../../../helpers/json_reader.dart';

void main() {
  final tRecipeModel = RecipeModel.fromJson(json.decode(readJson('recipe.json')));
  final tRecipeJson = json.decode(readJson('recipe.json'));

  group('Recipe test', () {
    test(
      'shoult be a subclass of RecipeEntity',
      () async {
        // assert
        expect(tRecipeModel, isA<RecipeEntity>());
      },
    );

    test(
      'shoult return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(readJson('recipe.json'));

        // act
        final result = RecipeModel.fromJson(jsonMap);

        // assert
        expect(result, equals(tRecipeModel));
      },
    );

    test(
      'shoult convert a RecipeModel to json format',
      () async {
        // act
        final result = tRecipeModel.toJson();

        // assert
        expect(result, tRecipeJson);
      },
    );
  });
}
