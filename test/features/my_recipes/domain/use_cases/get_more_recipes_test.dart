import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:recipes_app/features/index.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetMoreRecipesUC useCase;
  late MockRecipesRepository mockRecipesRepository;

  setUp(() {
    mockRecipesRepository = MockRecipesRepository();
    useCase = GetMoreRecipesUC(mockRecipesRepository);
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
    'shoult get more recipes from API by provided nextPageUrl',
    () async {
      // arrange
      when(mockRecipesRepository.getMoreRecipes('https://api.edamam.com/api/recipes/v2'))
          .thenAnswer((_) async => Right(tRecipesData));

      // act
      final result =
          await useCase(const Params(nextPageUrl: 'https://api.edamam.com/api/recipes/v2'));

      // assert
      expect(result, Right(tRecipesList));
      verify(mockRecipesRepository.getMoreRecipes('https://api.edamam.com/api/recipes/v2'));
      verifyNoMoreInteractions(mockRecipesRepository);
    },
  );
}
