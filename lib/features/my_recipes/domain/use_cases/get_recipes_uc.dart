import 'package:dartz/dartz.dart';
import 'package:recipes_app/core/index.dart';
import 'package:recipes_app/features/index.dart';

class GetRecipesUC {
  final RecipesRepository repository;

  GetRecipesUC(this.repository);

  Future<Either<Failure, RecipeResponseEntity>> call(NoParams params) async {
    return await repository.getRecipes();
  }
}
