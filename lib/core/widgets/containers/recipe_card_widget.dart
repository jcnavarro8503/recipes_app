import 'package:flutter/material.dart';
import 'package:recipes_app/core/index.dart';
import 'package:recipes_app/features/index.dart';

class RecipeCardWidget extends StatelessWidget {
  final RecipeEntity recipe;
  final double? width;
  final OnTap? onTap;

  const RecipeCardWidget({
    super.key,
    required this.recipe,
    this.width,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: width ?? double.infinity,
        child: Card(
          elevation: 0,
          color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
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
                      fontSize: 14,
                      fontFamily: 'WorkSans',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Text(
                    recipe.label,
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    IconDataWidget(
                      assetName: 'clock',
                      height: 15,
                      text: '${recipe.totalTime}',
                      sufix: 'min',
                    ),
                    const SizedBox(width: 15),
                    IconDataWidget(
                      assetName: 'portions',
                      height: 15,
                      text: '${recipe.ingredients.length}',
                      sufix: 'ppl',
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
