import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:recipes_app/core/index.dart';
import 'package:recipes_app/features/index.dart';

class RecipeOfTheDayWidget extends StatelessWidget {
  final RecipeEntity recipe;
  final OnTap? onTap;

  const RecipeOfTheDayWidget({
    super.key,
    required this.recipe,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
              Text(
                AppLocalizations.of(context)!.recipe,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      letterSpacing: 1.5,
                      fontFamily: 'WorkSans',
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                AppLocalizations.of(context)!.of_the_day,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 28,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'Roboto',
                    ),
              ),
              const SizedBox(height: 20),
              Text(
                recipe.label,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'WorkSans',
                ),
              ),
              const SizedBox(height: 5),
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
              const SizedBox(height: 10),
              ClipRRect(
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
            ],
          ),
        ),
      ),
    );
  }
}
