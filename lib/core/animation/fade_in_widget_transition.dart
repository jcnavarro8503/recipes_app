import 'package:flutter/material.dart';

class FadeInWidgetTransition extends StatefulWidget {
  final double beginOpacity;
  final double endOpacity;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final Widget child;

  const FadeInWidgetTransition({
    super.key,
    required this.beginOpacity,
    required this.endOpacity,
    this.duration = const Duration(milliseconds: 600),
    this.delay = const Duration(milliseconds: 100),
    this.curve = Curves.easeIn,
    required this.child,
  });

  @override
  State<FadeInWidgetTransition> createState() => _FadeInWidgetTransitionState();
}

class _FadeInWidgetTransitionState extends State<FadeInWidgetTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    opacityAnimation = Tween<double>(
      begin: widget.beginOpacity,
      end: widget.endOpacity,
    ).animate(CurvedAnimation(parent: controller, curve: widget.curve));

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
        return Opacity(
          opacity: opacityAnimation.value,
          child: widget.child,
        );
      },
    );
  }
}
