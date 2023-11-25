part of 'my_recipes_bloc.dart';

enum MyRecipesStateStatus { initial, loading, refresed, loaded, selected, error }

class MyRecipesState extends Equatable {
  final MyRecipesStateStatus status;
  final List<RecipeEntity> recipes;
  final String? nextUrl;
  final List<RecipeEntity>? left;
  final List<RecipeEntity>? right;
  final RecipeEntity? recipeOfTheDay;
  final RecipeEntity? recommended;
  final RecipeEntity selected;
  final Message? message;

  const MyRecipesState({
    required this.status,
    required this.recipes,
    this.nextUrl,
    this.left,
    this.right,
    this.recipeOfTheDay,
    this.recommended,
    required this.selected,
    this.message,
  });

  factory MyRecipesState.empty() {
    return MyRecipesState(
      status: MyRecipesStateStatus.initial,
      recipes: const [],
      nextUrl: null,
      left: const [],
      right: const [],
      recipeOfTheDay: null,
      recommended: null,
      selected: RecipeEntity.empty(),
      message: null,
    );
  }

  MyRecipesState copyWith(
      {MyRecipesStateStatus? status,
      List<RecipeEntity>? recipes,
      String? nextUrl,
      List<RecipeEntity>? left,
      List<RecipeEntity>? right,
      RecipeEntity? recipeOfTheDay,
      RecipeEntity? recommended,
      RecipeEntity? selected,
      Message? message}) {
    return MyRecipesState(
      status: status ?? this.status,
      recipes: recipes ?? this.recipes,
      nextUrl: nextUrl ?? this.nextUrl,
      left: left ?? this.left,
      right: right ?? this.right,
      recipeOfTheDay: recipeOfTheDay ?? this.recipeOfTheDay,
      recommended: recommended ?? this.recommended,
      selected: selected ?? this.selected,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        status,
        recipes,
        selected,
      ];
}
