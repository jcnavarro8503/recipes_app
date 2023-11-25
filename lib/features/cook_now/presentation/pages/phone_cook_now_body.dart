import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:recipes_app/core/index.dart';
import 'package:recipes_app/features/index.dart';

class PhoneCookNowBody extends StatefulWidget {
  const PhoneCookNowBody({super.key});

  @override
  State<PhoneCookNowBody> createState() => _PhoneCookNowBodyState();
}

class _PhoneCookNowBodyState extends State<PhoneCookNowBody> {
  @override
  Widget build(BuildContext context) {
    debugPrint(getIt<MyRecipesBloc>().state.selected.label);

    return SafeArea(
      child: BlocBuilder<MyRecipesBloc, MyRecipesState>(
        builder: (context, state) {
          return state.selected.label.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          getIt<HomeBloc>().add(const HomeIndexChangeEvent(index: 1));
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                      Text(AppLocalizations.of(context)!.back_to_recipes),
                    ],
                  ),
                )
              : Stack(
                  children: [
                    // Page content
                    Padding(
                      padding: const EdgeInsets.only(top: 65, left: 10, right: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SlidingTransition(
                              beginOffset: const Offset(.5, 0),
                              endOffset: const Offset(0, 0),
                              start: 0.3,
                              end: 1,
                              child: InstructionsCardWidget(
                                instructions:
                                    getIt<MyRecipesBloc>().state.selected.ingredients.map((e) {
                                  return Instruction(title: e.food, content: e.text);
                                }).toList(),
                              ),
                            ),
                            FadingTransition(
                              beginOpacity: 0.3,
                              endOpacity: 1,
                              start: 0.8,
                              end: 1,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: CookingTimerWidget(
                                  initial: getIt<MyRecipesBloc>().state.selected.totalTime.toInt(),
                                ),
                              ),
                            ),
                          ],
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
                        title: AppLocalizations.of(context)!.cook_now,
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
