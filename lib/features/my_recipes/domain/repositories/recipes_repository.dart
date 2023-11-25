import 'package:dartz/dartz.dart';
import 'package:recipes_app/core/index.dart';
import 'package:recipes_app/features/my_recipes/index.dart';

abstract class RecipesRepository {
  Future<Either<Failure, RecipeResponseEntity>> getRecipes();
  Future<Either<Failure, RecipeResponseEntity>> getMoreRecipes(String nextPageUrl);
}
