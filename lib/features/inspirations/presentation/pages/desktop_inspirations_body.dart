import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:recipes_app/core/index.dart';
import 'package:recipes_app/features/index.dart';

class DesktopInspirationsBody extends StatefulWidget {
  const DesktopInspirationsBody({super.key});

  @override
  State<DesktopInspirationsBody> createState() => _DesktopInspirationsBodyState();
}

class _DesktopInspirationsBodyState extends State<DesktopInspirationsBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.inspirations,
        ),
      ),
      body: Row(
        children: [
          const MyDrawer(),
          Expanded(
            child: BlocBuilder<MyRecipesBloc, MyRecipesState>(
              builder: (context, state) {
                return Stack(
                  children: [
                    // Page content
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
                      child: ListView(
                        children: [
                          const SizedBox(height: 80),

                          // Top list section
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                state.recipeOfTheDay != null
                                    ? SlidingTransition(
                                        beginOffset: const Offset(0.5, 0),
                                        endOffset: const Offset(0, 0),
                                        start: 0.2,
                                        end: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 10),
                                          child: SizedBox(
                                            width: MediaQuery.of(context).size.width * .7,
                                            child: RecipeOfTheDayWidget(
                                              recipe: state.recipeOfTheDay!,
                                              onTap: () {
                                                getIt<HomeBloc>()
                                                    .add(const HomeIndexChangeEvent(index: 2));
                                                context.go('/${RoutePath.cookNow.path}');
                                              },
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                                SlidingTransition(
                                  beginOffset: const Offset(0.5, 0),
                                  endOffset: const Offset(0, 0),
                                  start: 0.4,
                                  end: 1,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 40),
                                      DataCardWidget(
                                        title: AppLocalizations.of(context)!.cook,
                                        subtitle: AppLocalizations.of(context)!.like_pro,
                                        bottomText:
                                            AppLocalizations.of(context)!.thermomix_advanced,
                                      ),
                                      DataCardWidget(
                                        title: AppLocalizations.of(context)!.check,
                                        subtitle: AppLocalizations.of(context)!.new_updates,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Recommends
                          const SizedBox(height: 30),
                          state.recommended != null
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SlidingTransition(
                                      beginOffset: const Offset(0, 1),
                                      endOffset: const Offset(0, 0),
                                      start: 0,
                                      end: 1,
                                      child: RecomendationCardWidget(
                                        who: 'René Redzepi',
                                        recipe: state.recommended!,
                                        onTap: () {
                                          getIt<HomeBloc>()
                                              .add(const HomeIndexChangeEvent(index: 2));
                                          context.go('/${RoutePath.cookNow.path}');
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    SlidingTransition(
                                      beginOffset: const Offset(0, 1),
                                      endOffset: const Offset(0, 0),
                                      start: 0,
                                      end: 1,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          minimumSize: const Size.fromHeight(45),
                                          backgroundColor:
                                              Theme.of(context).scaffoldBackgroundColor,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              width: 2,
                                              color: Theme.of(context).primaryColor,
                                              style: BorderStyle.solid,
                                            ),
                                            borderRadius: BorderRadius.circular(12.0),
                                          ),
                                        ),
                                        child: Text(
                                          AppLocalizations.of(context)!.more_recipes,
                                          style: TextStyle(
                                            color: Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    ),

                    // Page Title
                    SlidingTransition(
                      beginOffset: const Offset(0, -1),
                      endOffset: const Offset(0, 0),
                      start: 0,
                      end: 0.5,
                      child: AppBarSearchWidget(
                        title: AppLocalizations.of(context)!.inspirations,
                        showBack: false,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
