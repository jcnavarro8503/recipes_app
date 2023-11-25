part of 'my_recipes_bloc.dart';

abstract class MyRecipesEvent extends Equatable {
  const MyRecipesEvent();

  @override
  List<Object> get props => [];
}

class MyRecipesGetEvent extends MyRecipesEvent {}

class MyRecipesGetMoreEvent extends MyRecipesEvent {}

class MyRecipesSelectRecipeEvent extends MyRecipesEvent {
  final RecipeEntity recipe;

  const MyRecipesSelectRecipeEvent({required this.recipe});

  @override
  List<Object> get props => [recipe];
}
