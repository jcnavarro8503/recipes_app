import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:recipes_app/core/index.dart';
import 'package:recipes_app/features/index.dart';

import '../../../../helpers/json_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MyRecipesBloc bloc;
  late MockGetRecipesUC mockGetRecipes;
  late MockGetMoreRecipesUC mockGetMoreRecipes;

  setUp(() {
    mockGetRecipes = MockGetRecipesUC();
    mockGetMoreRecipes = MockGetMoreRecipesUC();
    bloc = MyRecipesBloc(getRecipes: mockGetRecipes, getMoreRecipes: mockGetMoreRecipes);
  });

  final tRecipeStringList =
      (json.decode(readJson('recipe_list.json')) as List).map((e) => json.encode(e)).toList();
  final tRecipeList = tRecipeStringList
      .map<RecipeEntity>((item) => RecipeModel.fromJson(json.decode(item)).toEntity())
      .toList();
  const tNextPageUrl = '';
  // 'https://api.edamam.com/api/recipes/v2?app_key=aac60a26b0fc428122518bd4a017ad1a&mealType=Breakfast&mealType=Dinner&mealType=Lunch&_cont=CHcVQBtNNQphDmgVQntAEX4BY0t3AwEVX3dHCjdBNQN0DQMOSzETBjYTMVR6VlcDF2ZDUGpHZlInVxFqX3cWQT1OcV9xBB8VADQWVhFCPwoxXVZEITQeVDcBaR4-SQ%3D%3D&type=public&app_id=4be3fd3e';
  final tRecipeStringListTwise =
      (json.decode(readJson('recipe_list_twice.json')) as List).map((e) => json.encode(e)).toList();
  final tRecipeListTwice = tRecipeStringListTwise
      .map<RecipeEntity>((item) => RecipeModel.fromJson(json.decode(item)).toEntity())
      .toList();
  final tRecipesData = RecipeResponseEntity(recipes: tRecipeList, nextUrl: '');

  test(
    'shoult MyRecipesBloc initial status be Initial',
    () async {
      // assert
      expect(bloc.state.status, equals(MyRecipesStateStatus.initial));
    },
  );

  group('getRecipes', () {
    blocTest<MyRecipesBloc, MyRecipesState>(
      'emits [MyRecipesState with status loading, loaded] when MyRecipesGetEvent is fired.',
      build: () {
        when(mockGetRecipes.call(NoParams())).thenAnswer((_) async => Right(tRecipesData));
        return bloc;
      },
      act: (bloc) => bloc.add(MyRecipesGetEvent()),
      wait: const Duration(milliseconds: 500),
      expect: () => <MyRecipesState>[
        MyRecipesState(
            status: MyRecipesStateStatus.loading,
            recipes: const [],
            error: '',
            selected: RecipeEntity.empty()),
        MyRecipesState(
            status: MyRecipesStateStatus.loaded,
            recipes: tRecipeList,
            error: '',
            selected: RecipeEntity.empty()),
      ],
    );

    blocTest<MyRecipesBloc, MyRecipesState>(
      'emits [MyRecipesState with status error] when MyRecipesGetEvent is fired and something went wrong.',
      build: () {
        when(mockGetRecipes.call(NoParams())).thenAnswer((_) async => Left(ServerFailure()));
        return bloc;
      },
      seed: () => MyRecipesState(
          status: MyRecipesStateStatus.loaded,
          recipes: tRecipeList,
          error: '',
          selected: RecipeEntity.empty()),
      act: (bloc) => bloc.add(MyRecipesGetEvent()),
      wait: const Duration(milliseconds: 500),
      expect: () => <MyRecipesState>[
        MyRecipesState(
            status: MyRecipesStateStatus.loading,
            recipes: tRecipeList,
            error: '',
            selected: RecipeEntity.empty()),
        MyRecipesState(
            status: MyRecipesStateStatus.error,
            recipes: tRecipeList,
            error: 'Server Error',
            selected: RecipeEntity.empty()),
      ],
    );
  });

  group('getMoreRecipes', () {
    blocTest<MyRecipesBloc, MyRecipesState>(
      'emits [MyRecipesState with status loading, loaded] when MyRecipesGetMoreEvent is fired.',
      build: () {
        when(mockGetMoreRecipes.call(const Params(nextPageUrl: tNextPageUrl)))
            .thenAnswer((_) async => Right(tRecipesData));
        return bloc;
      },
      seed: () => MyRecipesState(
          status: MyRecipesStateStatus.initial,
          recipes: tRecipeList,
          error: '',
          selected: RecipeEntity.empty()),
      act: (bloc) => bloc.add(MyRecipesGetMoreEvent()),
      wait: const Duration(milliseconds: 500),
      expect: () => <MyRecipesState>[
        MyRecipesState(
            status: MyRecipesStateStatus.loading,
            recipes: tRecipeList,
            error: '',
            selected: RecipeEntity.empty()),
        MyRecipesState(
            status: MyRecipesStateStatus.loaded,
            recipes: tRecipeListTwice,
            error: '',
            selected: RecipeEntity.empty()),
      ],
    );

    blocTest<MyRecipesBloc, MyRecipesState>(
      'emits [MyRecipesState with status error] when MyRecipesGetMoreEvent is fired and something went wrong.',
      build: () {
        when(mockGetMoreRecipes.call(const Params(nextPageUrl: tNextPageUrl)))
            .thenAnswer((_) async => Left(ServerFailure()));
        return bloc;
      },
      seed: () => MyRecipesState(
          status: MyRecipesStateStatus.loaded,
          recipes: tRecipeList,
          error: '',
          selected: RecipeEntity.empty()),
      act: (bloc) => bloc.add(MyRecipesGetMoreEvent()),
      wait: const Duration(milliseconds: 500),
      expect: () => <MyRecipesState>[
        MyRecipesState(
            status: MyRecipesStateStatus.loading,
            recipes: tRecipeList,
            error: '',
            selected: RecipeEntity.empty()),
        MyRecipesState(
            status: MyRecipesStateStatus.error,
            recipes: tRecipeList,
            error: 'Server Error',
            selected: RecipeEntity.empty()),
      ],
    );
  });
}
