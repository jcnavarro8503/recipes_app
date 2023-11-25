import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:recipes_app/core/index.dart';
import 'package:recipes_app/features/index.dart';

class TabletMyRecipesBody extends StatefulWidget {
  const TabletMyRecipesBody({super.key});

  @override
  State<TabletMyRecipesBody> createState() => _TabletMyRecipesBodyState();
}

class _TabletMyRecipesBodyState extends State<TabletMyRecipesBody> {
  late final ScrollController scrollController;
  late RefreshController refreshController;
  double scrollOffset = 0;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController();
    refreshController = RefreshController(initialRefresh: false);

    scrollController.addListener(() {
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.position.pixels;
      if (maxScroll == currentScroll) {
        getIt<MyRecipesBloc>().add(MyRecipesGetMoreEvent());
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    refreshController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<MyRecipesBloc, MyRecipesState>(
        listener: (context, state) {
          debugPrint('MyRecipesBloc state has changed');

          if (state.status == MyRecipesStateStatus.refresed) {
            debugPrint('Refresh complete');
            refreshController.refreshCompleted();
          } else if (state.status == MyRecipesStateStatus.loaded) {
            debugPrint('Load complete');
            refreshController.loadComplete();
          } else if (state.status == MyRecipesStateStatus.selected) {
            debugPrint('Select complete');
            debugPrint(state.selected.label);
            getIt<HomeBloc>().add(HomeShowBottomSheetEvent());
          } else if (state.status == MyRecipesStateStatus.error) {
            refreshController.loadFailed();
            refreshController.refreshCompleted();
            refreshController.loadComplete();
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              // Page content
              SlidingTransition(
                beginOffset: const Offset(0, .8),
                endOffset: const Offset(0, 0),
                start: 0.4,
                end: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 65),
                  child: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    header: const WaterDropHeader(),
                    footer: CustomFooter(
                      builder: (context, mode) {
                        debugPrint('List state: $mode');
                        Widget body;
                        if (state.status == MyRecipesStateStatus.loaded) {
                          body = Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Text(AppLocalizations.of(context)!.pull_to_load),
                          );
                        } else if (state.status == MyRecipesStateStatus.loading) {
                          body = const CupertinoActivityIndicator();
                        } else if (state.status == MyRecipesStateStatus.error) {
                          body = Text(AppLocalizations.of(context)!.load_failed);
                        } else if (mode == LoadStatus.canLoading) {
                          body = Text(AppLocalizations.of(context)!.release_to_load);
                        } else {
                          body = Text(AppLocalizations.of(context)!.no_more);
                        }
                        return SizedBox(
                          height: 55,
                          child: Center(child: body),
                        );
                      },
                    ),
                    controller: refreshController,
                    onRefresh: () {
                      getIt<MyRecipesBloc>().add(MyRecipesGetEvent());
                    },
                    onLoading: () {
                      getIt<MyRecipesBloc>().add(MyRecipesGetMoreEvent());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Left
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: state.left!.map((recipe) {
                                  return RecipeCardWidget(
                                    recipe: recipe,
                                    onTap: () {
                                      getIt<MyRecipesBloc>()
                                          .add(MyRecipesSelectRecipeEvent(recipe: recipe));
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          ),

                          // Right
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: state.right!.map((recipe) {
                                  return RecipeCardWidget(
                                    recipe: recipe,
                                    onTap: () {
                                      getIt<MyRecipesBloc>()
                                          .add(MyRecipesSelectRecipeEvent(recipe: recipe));
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Grid view approach
                      //     MasonryGridView.builder(
                      //   itemCount: state.recipes.length,
                      //   gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      //     crossAxisCount: 2,
                      //   ),
                      //   itemBuilder: (context, index) {
                      //     double padding = 0;
                      //     if (index == 0) {
                      //       padding = 25;
                      //     } else if (index == 1) {
                      //       padding = 55;
                      //     }
                      //     return Padding(
                      //       padding: EdgeInsets.only(top: padding),
                      //       child: RecipeCardWidget(
                      //         recipe: state.recipes[index],
                      //         onTap: () {},
                      //       ),
                      //     );
                      //   },
                      // ),

                      // // Column approach
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     // Left
                      //     Expanded(
                      //       child: Padding(
                      //         padding: const EdgeInsets.only(top: 60),
                      //         child: Column(
                      //           mainAxisSize: MainAxisSize.min,
                      //           children: state.left!.map((recipe) {
                      //             return RecipeCardWidget(
                      //               recipe: recipe,
                      //               onTap: () {},
                      //             );
                      //           }).toList(),
                      //         ),
                      //       ),
                      //     ),

                      //     // Right
                      //     Expanded(
                      //       child: Padding(
                      //         padding: const EdgeInsets.only(top: 80),
                      //         child: Column(
                      //           mainAxisSize: MainAxisSize.min,
                      //           children: state.right!.map((recipe) {
                      //             return RecipeCardWidget(
                      //               recipe: recipe,
                      //               onTap: () {},
                      //             );
                      //           }).toList(),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ),
                  ),
                ),
              ),

              // Page Title
              SlidingTransition(
                beginOffset: const Offset(0, -1),
                endOffset: const Offset(0, 0),
                start: 0,
                end: 0.4,
                child: AppBarWidget(
                  title: AppLocalizations.of(context)!.my_recipes,
                  showBack: false,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
