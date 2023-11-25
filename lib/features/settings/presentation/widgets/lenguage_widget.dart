import 'package:flutter/material.dart';
import 'package:recipes_app/core/index.dart';

class LanguageWidget extends StatelessWidget {
  final String title;
  final bool active;
  final OnTap? onTap;

  const LanguageWidget({
    super.key,
    required this.title,
    this.active = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: active ? 5 : 1,
      margin: const EdgeInsets.only(bottom: 5, right: 10),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
