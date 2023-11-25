import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:recipes_app/core/index.dart';
import 'package:recipes_app/features/index.dart';

class TabletCookNowBody extends StatefulWidget {
  const TabletCookNowBody({super.key});

  @override
  State<TabletCookNowBody> createState() => _TabletCookNowBodyState();
}

class _TabletCookNowBodyState extends State<TabletCookNowBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<MyRecipesBloc, MyRecipesState>(
        builder: (context, state) {
          return Stack(
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
                          instructions: state.selected.ingredients.map((e) {
                            return Instruction(title: e.food, content: e.text);
                          }).toList(),
                        ),
                      ),
                      const FadingTransition(
                        beginOpacity: 0.3,
                        endOpacity: 1,
                        start: 0.8,
                        end: 1,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: CookingTimerWidget(),
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
