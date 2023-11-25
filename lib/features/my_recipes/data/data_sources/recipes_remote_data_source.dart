import 'dart:convert';
import 'package:http/http.dart';
import 'package:recipes_app/core/index.dart';
import 'package:recipes_app/features/index.dart';

abstract class RecipesRemoteDataSource {
  /// Calls the https://api.edamam.com/api/recipes/v2 endpoint.
  ///
  /// Throw a [ServerException] for all errors
  Future<RecipeResponseModel> getRecipes();

  /// Calls the https://api.edamam.com/api/recipes/v2?app_key=aac60a26b0fc428122518bd4a017ad1a
  ///                                                 &mealType=Breakfast&mealType=Dinner&mealType=Lunch
  ///                                                 &_cont=CHcVQBtNNQphDmgVQntAEX4BY0t3AwEVX3dHCjdBNQN0DQMOSzETBjYTMVR6VlcDF2ZDUGpHZlInVxFqX3cWQT1OcV9xBB8VADQWVhFCPwoxXVZEITQeVDcBaR4-SQ%3D%3D
  ///                                                 &type=public&app_id=4be3fd3e endpoint.
  ///
  /// Throw a [ServerException] for all errors
  Future<RecipeResponseModel> getMoreRecipes(String nextPageUrl);
}

class RecipesRemoteDataSourceImpl implements RecipesRemoteDataSource {
  final ApiHandler apiHandler;

  RecipesRemoteDataSourceImpl({required this.apiHandler});

  @override
  Future<RecipeResponseModel> getRecipes() async {
    try {
      final response = await apiHandler.get(
          params:
              "?type=public&app_id=${ApiKeys.appId}&app_key=${ApiKeys.appKey}&mealType=Breakfast&mealType=Dinner&mealType=Lunch");
      return proccessResponse(response);
    } catch (ex) {
      throw ServerFailure(message: ErrorMessage('Error', ex.toString()));
    }
  }

  @override
  Future<RecipeResponseModel> getMoreRecipes(String nextPageUrl) async {
    try {
      final response = await apiHandler.getCustomeUrl(url: nextPageUrl);
      return proccessResponse(response);
    } catch (ex) {
      throw ServerFailure(message: ErrorMessage('Error', ex.toString()));
    }
  }

  RecipeResponseModel proccessResponse(Response response) {
    Map<String, dynamic> data = json.decode(response.body);

    if (response.statusCode == 200) {
      return RecipeResponseModel.fromJson(data);
    }
    throw Exception('Something went wrong');
  }
}
