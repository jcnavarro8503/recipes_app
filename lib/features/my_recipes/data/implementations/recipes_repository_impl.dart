import 'package:dartz/dartz.dart';
import 'package:recipes_app/core/index.dart';
import 'package:recipes_app/features/my_recipes/index.dart';

class RecipesRepositoryImpl implements RecipesRepository {
  final RecipesRemoteDataSource remote;
  final RecipesLocalDataSource local;
  final NetworkInfo networkInfo;

  RecipesRepositoryImpl({
    required this.remote,
    required this.local,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, RecipeResponseEntity>> getRecipes() async {
    if (await networkInfo.isOnLine) {
      try {
        final remoteRecipesData = await remote.getRecipes();
        await local.cacheRecipes(remoteRecipesData);
        return Right(remoteRecipesData.toEntity());
      } on ServerFailure {
        return Left(ServerFailure(message: ErrorMessage('Could not load recipes', '')));
      }
    } else {
      try {
        final localRecipesData = await local.getLastRecipesCached();
        return Right(localRecipesData.toEntity());
      } on CacheFailure {
        return Left(CacheFailure(message: InfoMessage('No cached data', '')));
      }
    }
  }

  @override
  Future<Either<Failure, RecipeResponseEntity>> getMoreRecipes(String nextPageUrl) async {
    if (await networkInfo.isOnLine) {
      try {
        final remoteRecipesData = await remote.getMoreRecipes(nextPageUrl);
        await local.cacheRecipes(remoteRecipesData);
        return Right(remoteRecipesData.toEntity());
      } on ServerFailure {
        return Left(ServerFailure(message: ErrorMessage('Could not load more recipes', '')));
      }
    } else {
      try {
        final localRecipesData = await local.getLastRecipesCached();
        return Right(localRecipesData.toEntity());
      } on CacheFailure {
        return Left(CacheFailure(message: InfoMessage('No cached data', '')));
      }
    }
  }
}
