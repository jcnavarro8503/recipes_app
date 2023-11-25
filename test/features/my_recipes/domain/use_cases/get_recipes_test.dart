import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:recipes_app/core/index.dart';
import 'package:recipes_app/features/index.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetRecipesUC useCase;
  late MockRecipesRepository mockRecipesRepository;

  setUp(() {
    mockRecipesRepository = MockRecipesRepository();
    useCase = GetRecipesUC(mockRecipesRepository);
  });

  final tRecipesList = [
    const RecipeEntity(
      uri: 'uri',
      label: 'label',
      image: 'image',
      url: 'url',
      ingredientLines: [],
      ingredients: [],
      totalTime: 0,
      cuisineType: [],
      mealType: [],
      dishType: [],
    )
  ];
  final tRecipesData = RecipeResponseEntity(recipes: tRecipesList, nextUrl: '');

  test(
    'shoult get the recipes from API',
    () async {
      // arrange
      when(mockRecipesRepository.getRecipes()).thenAnswer((_) async => Right(tRecipesData));

      // act
      final result = await useCase(NoParams());

      // assert
      expect(result, Right(tRecipesList));
      verify(mockRecipesRepository.getRecipes());
      verifyNoMoreInteractions(mockRecipesRepository);
    },
  );
}
