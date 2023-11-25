import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FadingTransition extends StatelessWidget {
  final double beginOpacity;
  final double endOpacity;
  final double start;
  final double end;
  final Curve curve;
  final Widget child;

  const FadingTransition({
    super.key,
    required this.beginOpacity,
    required this.endOpacity,
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
        return Opacity(
          opacity: animation.value,
          child: child,
        );
      },
    );
  }
}
