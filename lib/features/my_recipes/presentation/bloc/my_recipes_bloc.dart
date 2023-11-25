import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:recipes_app/core/index.dart';
import 'package:recipes_app/features/index.dart';

part 'my_recipes_event.dart';
part 'my_recipes_state.dart';

class MyRecipesBloc extends Bloc<MyRecipesEvent, MyRecipesState> {
  final GetRecipesUC getRecipes;
  final GetMoreRecipesUC getMoreRecipes;

  MyRecipesBloc({required this.getRecipes, required this.getMoreRecipes})
      : super(MyRecipesState.empty()) {
    on<MyRecipesEvent>(
      (event, emit) async {
        if (event is MyRecipesGetEvent) {
          await onMyRecipesGetEvent(event, emit);
        } else if (event is MyRecipesGetMoreEvent) {
          await onMyRecipesGetMoreEvent(event, emit);
        } else if (event is MyRecipesSelectRecipeEvent) {
          await onMyRecipesSelectRecipeEvent(event, emit);
        }
      },
      transformer: sequential(),
    );

    add(MyRecipesGetEvent());
  }

  Future<void> onMyRecipesGetEvent(MyRecipesGetEvent event, Emitter<MyRecipesState> emit) async {
    debugPrint('get recipes');

    emit(state.copyWith(status: MyRecipesStateStatus.loading));

    final response = await getRecipes.call(NoParams());

    response.fold(
      (failure) {
        debugPrint('get recipes failure');
        debugPrint(failure.message!.title);
        emit(state.copyWith(
          status: MyRecipesStateStatus.error,
          message: failure.message,
        ));
      },
      (data) {
        debugPrint('get recipes success');

        List<RecipeEntity> pleft = [];
        List<RecipeEntity> pright = [];
        if (data.recipes.isNotEmpty) {
          for (var element in data.recipes) {
            bool even = (data.recipes.indexOf(element) % 2 == 0);
            if (even) {
              pleft.add(element);
            } else {
              pright.add(element);
            }
          }
        }

        emit(state.copyWith(
          status: MyRecipesStateStatus.refresed,
          recipes: data.recipes,
          nextUrl: data.nextUrl,
          left: pleft,
          right: pright,
          recipeOfTheDay: data.recipes.isNotEmpty ? data.recipes.first : null,
          recommended: data.recipes.isNotEmpty ? data.recipes.elementAt(1) : null,
          selected: data.recipes.isNotEmpty ? data.recipes.first : null,
          message: null,
        ));
      },
    );
  }

  Future<void> onMyRecipesGetMoreEvent(
      MyRecipesGetMoreEvent event, Emitter<MyRecipesState> emit) async {
    debugPrint('get more recipes');

    emit(state.copyWith(status: MyRecipesStateStatus.loading));

    final response = await getMoreRecipes.call(Params(nextPageUrl: state.nextUrl!));

    response.fold(
      (failure) {
        debugPrint('get more recipes failure');
        debugPrint(failure.message!.title);
        emit(state.copyWith(
          status: MyRecipesStateStatus.error,
          message: failure.message,
        ));
      },
      (data) {
        debugPrint('get more recipes success');

        List<RecipeEntity> precipes = state.recipes;
        precipes.addAll(data.recipes);

        List<RecipeEntity> pleft = state.left!;
        List<RecipeEntity> pright = state.right!;
        if (data.recipes.isNotEmpty) {
          for (var element in data.recipes) {
            bool even = (data.recipes.indexOf(element) % 2 == 0);
            if (even) {
              pleft.add(element);
            } else {
              pright.add(element);
            }
          }
        }

        debugPrint('precipes modification');
        debugPrint(precipes.length.toString());

        emit(state.copyWith(
          status: MyRecipesStateStatus.loaded,
          recipes: precipes,
          nextUrl: data.nextUrl,
          left: pleft,
          right: pright,
          message: null,
        ));
      },
    );
  }

  Future<void> onMyRecipesSelectRecipeEvent(
      MyRecipesSelectRecipeEvent event, Emitter<MyRecipesState> emit) async {
    debugPrint('selecting recipe ${event.recipe.label}');

    emit(state.copyWith(
      status: MyRecipesStateStatus.selected,
      selected: event.recipe,
    ));
  }
}
