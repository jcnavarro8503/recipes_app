import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:recipes_app/core/index.dart';
import 'package:recipes_app/features/index.dart';

class RecomendationCardWidget extends StatelessWidget {
  final String? who;
  final RecipeEntity recipe;
  final OnTap? onTap;

  const RecomendationCardWidget({
    super.key,
    this.who,
    required this.recipe,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        who != null
            ? Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      who!,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            letterSpacing: 1.5,
                            fontFamily: 'WorkSans',
                          ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      AppLocalizations.of(context)!.recommends_you,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 28,
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Roboto',
                          ),
                    ),
                  ],
                ),
              )
            : Container(),
        InkWell(
          onTap: onTap,
          child: Card(
            elevation: 0,
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                right: 15,
                bottom: 15,
                left: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.network(
                        recipe.image,
                        fit: BoxFit.fitWidth,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/placeholder.png',
                            fit: BoxFit.fitWidth,
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      recipe.label,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'WorkSans',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Text(
                      recipe.label,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const ThemeSvgWidget(
                        path: 'icons',
                        assetName: 'clock',
                        height: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${recipe.totalTime} min',
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Nunito',
                        ),
                      ),
                      const SizedBox(width: 15),
                      const ThemeSvgWidget(
                        path: 'icons',
                        assetName: 'portions',
                        height: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${recipe.ingredients.length} ppl',
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Nunito',
                        ),
                      ),
                      const SizedBox(width: 15),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
