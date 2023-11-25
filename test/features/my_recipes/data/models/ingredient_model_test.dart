import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:recipes_app/features/index.dart';

import '../../../../helpers/json_reader.dart';

void main() {
  final tIngredientModel = IngredientModel.fromJson(json.decode(readJson('ingredient.json')));
  final tIngredientJson = json.decode(readJson('ingredient.json'));

  group('Ingredient tests', () {
    test(
      'shoult be a subclass of IngredientEntity',
      () async {
        // assert
        expect(tIngredientModel, isA<IngredientEntity>());
      },
    );

    test(
      'shoult return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(readJson('ingredient.json'));

        // act
        final result = IngredientModel.fromJson(jsonMap);

        // assert
        expect(result, equals(tIngredientModel));
      },
    );

    test(
      'shoult convert a RecipeModel to json format',
      () async {
        // act
        final result = tIngredientModel.toJson();

        // assert
        expect(result, tIngredientJson);
      },
    );
  });
}
