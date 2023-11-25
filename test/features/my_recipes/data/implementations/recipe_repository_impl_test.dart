import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recipes_app/core/index.dart';
import 'package:recipes_app/features/index.dart';

import '../../../../helpers/json_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockRecipesRemoteDataSource mockRecipesRemoteDataSource;
  late MockRecipesLocalDataSource mockRecipesLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late RecipesRepositoryImpl repositoryImpl;

  setUp(() {
    mockRecipesRemoteDataSource = MockRecipesRemoteDataSource();
    mockRecipesLocalDataSource = MockRecipesLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = RecipesRepositoryImpl(
      remote: mockRecipesRemoteDataSource,
      local: mockRecipesLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runOnLineTest(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isOnLine).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runOffLineTest(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isOnLine).thenAnswer((_) async => false);
      });

      body();
    });
  }

  final tRecipeListJson = json.decode(readJson('recipe_list.json')) as List;
  final tRecipeListString = tRecipeListJson.map((e) => json.encode(e)).toList();
  final tRecipeListModels = tRecipeListString
      .map<RecipeModel>((item) => RecipeModel.fromJson(json.decode(item)))
      .toList();
  final tRecipeListEntities =
      tRecipeListModels.map<RecipeEntity>((item) => item.toEntity()).toList();
  const tNextPageUrl =
      'https://api.edamam.com/api/recipes/v2?app_key=aac60a26b0fc428122518bd4a017ad1a&mealType=Breakfast&mealType=Dinner&mealType=Lunch&_cont=CHcVQBtNNQphDmgVQntAEX4BY0t3AwEVX3dHCjdBNQN0DQMOSzETBjYTMVR6VlcDF2ZDUGpHZlInVxFqX3cWQT1OcV9xBB8VADQWVhFCPwoxXVZEITQeVDcBaR4-SQ%3D%3D&type=public&app_id=4be3fd3e';
  final tRecipesData = RecipeResponseModel(recipes: tRecipeListModels, nextUrl: tNextPageUrl);

  group('getRecipes', () {
    test(
      'shoult check if device is conected',
      () async {
        // arrange
        when(mockNetworkInfo.isOnLine).thenAnswer((_) async => true);

        // act
        repositoryImpl.getRecipes();

        // assert
        verify(mockNetworkInfo.isOnLine);
      },
    );

    runOnLineTest(() {
      test(
        'shoult get recipes from remote data source on device is online',
        () async {
          // arrange
          when(mockRecipesRemoteDataSource.getRecipes()).thenAnswer((_) async => tRecipesData);

          // act
          final result = await repositoryImpl.getRecipes();

          // assert
          verify(mockRecipesRemoteDataSource.getRecipes());
          verify(mockRecipesLocalDataSource.cacheRecipes(tRecipesData));
          // expect(result, equals(Right<Failure, List<RecipeEntity>>(tRecipeListEntities)));
        },
      );

      test(
        'shoult get server failure from remote data source on device is online',
        () async {
          // arrange
          when(mockRecipesRemoteDataSource.getRecipes()).thenThrow(ServerFailure());

          // act
          final result = await repositoryImpl.getRecipes();

          // assert
          verify(mockRecipesRemoteDataSource.getRecipes());
          verifyZeroInteractions(mockRecipesLocalDataSource);
          // expect(result, same(Left<Failure, List<RecipeEntity>>(ServerFailure())));
        },
      );
    });

    runOffLineTest(() {
      test(
        'shoult get recipes from local data source on device is offline if there is cached data',
        () async {
          // arrange
          when(mockRecipesLocalDataSource.getLastRecipesCached())
              .thenAnswer((_) async => tRecipesData);

          // act
          final result = await repositoryImpl.getRecipes();

          // assert
          verifyZeroInteractions(mockRecipesRemoteDataSource);
          verify(mockRecipesLocalDataSource.getLastRecipesCached());
          // expect(result, equals(Right(tRecipeListEntities)));
        },
      );

      test(
        'shoult get cache failure from local data source on device is offline if there is no cached data',
        () async {
          // arrange
          when(mockRecipesLocalDataSource.getLastRecipesCached()).thenThrow(CacheFailure());

          // act
          final result = await repositoryImpl.getRecipes();

          // assert
          verifyZeroInteractions(mockRecipesRemoteDataSource);
          verify(mockRecipesLocalDataSource.getLastRecipesCached());
          // expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });

  group('getMoreRecipes', () {
    test(
      'shoult check if device is conected',
      () async {
        // arrange
        when(mockNetworkInfo.isOnLine).thenAnswer((_) async => true);

        // act
        repositoryImpl.getMoreRecipes(tNextPageUrl);

        // assert
        verify(mockNetworkInfo.isOnLine);
      },
    );

    runOnLineTest(() {
      test(
        'shoult get recipes from remote data source on device is online',
        () async {
          // arrange
          when(mockRecipesRemoteDataSource.getMoreRecipes(tNextPageUrl))
              .thenAnswer((_) async => tRecipesData);

          // act
          final result = await repositoryImpl.getMoreRecipes(tNextPageUrl);

          // assert
          verify(mockRecipesRemoteDataSource.getMoreRecipes(tNextPageUrl));
          verify(mockRecipesLocalDataSource.cacheRecipes(tRecipesData));
          // expect(result, equals(Right(tRecipeListEntities)));
        },
      );

      test(
        'shoult get server failure from remote data source on device is online',
        () async {
          // arrange
          when(mockRecipesRemoteDataSource.getMoreRecipes(tNextPageUrl)).thenThrow(ServerFailure());

          // act
          final result = await repositoryImpl.getMoreRecipes(tNextPageUrl);

          // assert
          verify(mockRecipesRemoteDataSource.getMoreRecipes(tNextPageUrl));
          verifyZeroInteractions(mockRecipesLocalDataSource);
          // expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runOffLineTest(() {
      test(
        'shoult get recipes from local data source on device is offline if there is cached data',
        () async {
          // arrange
          when(mockRecipesLocalDataSource.getLastRecipesCached())
              .thenAnswer((_) async => tRecipesData);

          // act
          final result = await repositoryImpl.getMoreRecipes(tNextPageUrl);

          // assert
          verifyZeroInteractions(mockRecipesRemoteDataSource);
          verify(mockRecipesLocalDataSource.getLastRecipesCached());
          // expect(result, equals(Right(tRecipeListEntities)));
        },
      );

      test(
        'shoult get cache failure from local data source on device is offline if there is no cached data',
        () async {
          // arrange
          when(mockRecipesLocalDataSource.getLastRecipesCached()).thenThrow(CacheFailure());

          // act
          final result = await repositoryImpl.getMoreRecipes(tNextPageUrl);

          // assert
          verifyZeroInteractions(mockRecipesRemoteDataSource);
          verify(mockRecipesLocalDataSource.getLastRecipesCached());
          // expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });
}
