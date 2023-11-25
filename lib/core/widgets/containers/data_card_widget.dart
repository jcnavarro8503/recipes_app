import 'package:flutter/material.dart';
import 'package:recipes_app/core/index.dart';

class DataCardWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? bottomText;
  final OnTap? onTap;

  const DataCardWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.bottomText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
              title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    letterSpacing: 1.5,
                    fontFamily: 'WorkSans',
                  ),
            ),
            subtitle != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      subtitle!,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 28,
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Roboto',
                          ),
                    ),
                  )
                : Container(),
            bottomText != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Text(
                      bottomText!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'WorkSans',
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
