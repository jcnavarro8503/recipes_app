import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recipes_app/core/index.dart';
import 'package:recipes_app/features/index.dart';
import 'package:http/http.dart' as http;

import '../../../../helpers/json_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late RecipesRemoteDataSourceImpl remote;
  late MockApiHandler mockApiHandler;

  setUp(() {
    mockApiHandler = MockApiHandler();
    remote = RecipesRemoteDataSourceImpl(apiHandler: mockApiHandler);
  });

  void setUpMockApiHandlerGetSuccess() {
    when(mockApiHandler.get(path: anyNamed('path'), params: anyNamed('params')))
        .thenAnswer((_) async => http.Response(readJson('recipes_response_body.json'), 200));
  }

  void setUpMockApiHandlerGetFailure() {
    when(mockApiHandler.get(path: anyNamed('path'), params: anyNamed('params')))
        .thenAnswer((_) async => http.Response('something went wrong', 500));
  }

  void setUpMockApiHandlerGetMoreSuccess() {
    when(mockApiHandler.getCustomeUrl(url: anyNamed('url')))
        .thenAnswer((_) async => http.Response(readJson('recipes_response_body.json'), 200));
  }

  void setUpMockApiHandlerGetMoreFailure() {
    when(mockApiHandler.getCustomeUrl(url: anyNamed('url')))
        .thenAnswer((_) async => http.Response('something went wrong', 500));
  }

  final tRecipeListJson = json.decode(readJson('recipe_list.json')) as List;
  final tRecipeListString = tRecipeListJson.map((e) => json.encode(e)).toList();
  final tRecipeListModels = tRecipeListString
      .map<RecipeModel>((item) => RecipeModel.fromJson(json.decode(item)))
      .toList();
  const nextPageUrl =
      'https://api.edamam.com/api/recipes/v2?app_key=aac60a26b0fc428122518bd4a017ad1a&mealType=Breakfast&mealType=Dinner&mealType=Lunch&_cont=CHcVQBtNNQphDmgVQntAEX4BY0t3AwEVX3dHCjdBNQN0DQMOSzETBjYTMVR6VlcDF2ZDUGpHZlInVxFqX3cWQT1OcV9xBB8VADQWVhFCPwoxXVZEITQeVDcBaR4-SQ%3D%3D&type=public&app_id=4be3fd3e';

  group('getRecipes', () {
    test(
      'shoult perform Get request on recipes API endpoint',
      () async {
        // arrange
        setUpMockApiHandlerGetSuccess();

        // act
        remote.getRecipes();

        // assert
        verify(mockApiHandler.get(
            path: '',
            params:
                "?type=public&app_id=${ApiKeys.appId}&app_key=${ApiKeys.appKey}&mealType=Breakfast&mealType=Dinner&mealType=Lunch"));
      },
    );

    test(
      'shoult return a RecipesModel List when response statusCode is 200 (success)',
      () async {
        // arrange
        setUpMockApiHandlerGetSuccess();

        // act
        final result = await remote.getRecipes();

        // assert
        expect(result, equals(tRecipeListModels));
      },
    );

    test(
      'shoult throw ServerFailure when response statusCode is 4xx or 5xx (failure)',
      () async {
        // arrange
        setUpMockApiHandlerGetFailure();

        // act
        final call = remote.getRecipes;

        // assert
        expect(() => call(), throwsA(const TypeMatcher<ServerFailure>()));
      },
    );
  });

  group('getMoreRecipes', () {
    test(
      'shoult perform Get request on more recipes API endpoint',
      () async {
        // arrange
        setUpMockApiHandlerGetMoreSuccess();

        // act
        remote.getMoreRecipes(nextPageUrl);

        // assert
        verify(mockApiHandler.getCustomeUrl(url: nextPageUrl));
      },
    );

    test(
      'shoult return a RecipesModel List when response statusCode is 200 (success)',
      () async {
        // arrange
        setUpMockApiHandlerGetMoreSuccess();

        // act
        final result = await remote.getMoreRecipes(nextPageUrl);

        // assert
        expect(result, equals(tRecipeListModels));
      },
    );

    test(
      'shoult throw ServerFailure when response statusCode is 4xx or 5xx (failure)',
      () async {
        // arrange
        setUpMockApiHandlerGetMoreFailure();

        // act
        final call = remote.getMoreRecipes;

        // assert
        expect(() => call(nextPageUrl), throwsA(const TypeMatcher<ServerFailure>()));
      },
    );
  });
}
