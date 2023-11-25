import 'package:flutter/material.dart';
import 'package:recipes_app/core/index.dart';

class AppBarWidget extends StatefulWidget {
  final String title;
  final bool showBack;
  final OnTap? backAction;

  const AppBarWidget({
    super.key,
    required this.title,
    this.showBack = true,
    this.backAction,
  });

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).scaffoldBackgroundColor,
            Theme.of(context).scaffoldBackgroundColor.withOpacity(0),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [.85, 1],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 25, left: 10, right: 10, bottom: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.showBack
                ? IconButton(onPressed: widget.backAction, icon: const Icon(Icons.arrow_back))
                : const SizedBox(width: 0),
            Expanded(
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'WorkSans',
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
