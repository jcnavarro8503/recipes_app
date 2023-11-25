import 'package:flutter/material.dart';
import 'package:recipes_app/core/index.dart';

class AppBarSearchWidget extends StatefulWidget {
  final String title;
  final bool showBack;
  final OnTap? backAction;
  final OnTextChanged? textChanged;

  const AppBarSearchWidget({
    super.key,
    required this.title,
    this.showBack = true,
    this.backAction,
    this.textChanged,
  });

  @override
  State<AppBarSearchWidget> createState() => _AppBarSearchWidgetState();
}

class _AppBarSearchWidgetState extends State<AppBarSearchWidget> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> sizeAnimation;
  bool open = false;
  String criteria = '';

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 24, end: 30),
        weight: 50,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 30, end: 24),
        weight: 50,
      ),
    ]).animate(animationController);

    animationController.addStatusListener((status) {
      setState(() {
        open = status == AnimationStatus.completed;
      });
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.only(bottom: 10),
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
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.showBack
                ? IconButton(onPressed: widget.backAction, icon: const Icon(Icons.arrow_back))
                : const SizedBox(width: 0),
            Expanded(
              child: Stack(
                children: [
                  AnimatedSlide(
                    duration: const Duration(milliseconds: 300),
                    offset: open ? const Offset(-1, 0) : const Offset(0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.title,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'WorkSans',
                            ),
                      ),
                    ),
                  ),
                  AnimatedSlide(
                    duration: const Duration(milliseconds: 300),
                    offset: open ? const Offset(0, 0) : const Offset(2, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .8,
                        child: TextFormField(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedBuilder(
              animation: animationController,
              builder: (context, _) {
                return IconButton(
                  onPressed: () {
                    open ? animationController.reverse() : animationController.forward();
                  },
                  icon: Icon(open ? Icons.close : Icons.search, size: sizeAnimation.value),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
