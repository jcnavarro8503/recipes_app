import 'package:flutter/material.dart';

class FadeInSlidingAlignTransition extends StatefulWidget {
  final double beginOpacity;
  final double endOpacity;
  final Offset beginOffset;
  final Offset endOffset;
  final Alignment align;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final Widget child;

  const FadeInSlidingAlignTransition({
    super.key,
    required this.beginOpacity,
    required this.endOpacity,
    required this.beginOffset,
    required this.endOffset,
    required this.align,
    this.duration = const Duration(milliseconds: 600),
    this.delay = const Duration(milliseconds: 10),
    this.curve = Curves.easeIn,
    required this.child,
  });

  @override
  State<FadeInSlidingAlignTransition> createState() => _FadeInSlidingAlignTransitionState();
}

class _FadeInSlidingAlignTransitionState extends State<FadeInSlidingAlignTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late CurvedAnimation curve;
  late Animation<double> opacityAnimation;
  late Animation<Offset> positionAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    curve = CurvedAnimation(parent: controller, curve: widget.curve);

    opacityAnimation = Tween<double>(
      begin: widget.beginOpacity,
      end: widget.endOpacity,
    ).animate(curve);
    positionAnimation = Tween<Offset>(
      begin: widget.beginOffset,
      end: widget.endOffset,
    ).animate(curve);

    Future.delayed(widget.delay, () => controller.forward());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      child: widget.child,
      builder: (context, child) {
        return SlideTransition(
          position: positionAnimation,
          child: Align(
            alignment: widget.align,
            child: Opacity(
              opacity: opacityAnimation.value,
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}
