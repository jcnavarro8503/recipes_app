import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SlidingTransition extends StatelessWidget {
  final Offset beginOffset;
  final Offset endOffset;
  final double start;
  final double end;
  final Curve curve;
  final Widget child;

  const SlidingTransition({
    super.key,
    required this.beginOffset,
    required this.endOffset,
    this.start = 0,
    this.end = 1,
    this.curve = Curves.easeIn,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final animation = Provider.of<Animation<double>>(context, listen: false);

    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(begin: beginOffset, end: endOffset).animate(
            CurvedAnimation(
              parent: animation,
              curve: Interval(start, end, curve: curve),
            ),
          ),
          child: Opacity(
            opacity: animation.value,
            child: child,
          ),
        );
      },
    );
  }
}
