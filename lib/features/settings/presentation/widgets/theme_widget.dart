import 'package:flutter/material.dart';
import 'package:recipes_app/core/index.dart';

class ThemeWidget extends StatelessWidget {
  final String title;
  final ThemeData theme;
  final bool active;
  final OnTap? onTap;

  const ThemeWidget({
    super.key,
    required this.title,
    required this.theme,
    this.active = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: theme.dialogBackgroundColor,
      elevation: active ? 8 : 1,
      margin: const EdgeInsets.only(bottom: 5, right: 10),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              title,
              style: theme.textTheme.bodyLarge!.copyWith(
                color: theme.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
