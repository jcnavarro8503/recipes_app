import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:recipes_app/core/index.dart';
import 'package:recipes_app/features/index.dart';

class GetMoreRecipesUC {
  final RecipesRepository repository;

  GetMoreRecipesUC(this.repository);

  Future<Either<Failure, RecipeResponseEntity>> call(Params params) async {
    return await repository.getMoreRecipes(params.nextPageUrl);
  }
}

class Params extends Equatable {
  final String nextPageUrl;

  const Params({required this.nextPageUrl});

  @override
  List<Object?> get props => [nextPageUrl];
}
