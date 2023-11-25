import 'package:flutter/material.dart';

class SlideInTransition extends StatefulWidget {
  final Offset beginOffset;
  final Offset endOffset;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final Widget child;

  const SlideInTransition({
    super.key,
    required this.beginOffset,
    required this.endOffset,
    this.duration = const Duration(milliseconds: 600),
    this.delay = const Duration(milliseconds: 100),
    this.curve = Curves.easeIn,
    required this.child,
  });

  @override
  State<SlideInTransition> createState() => _SlideInTransitionState();
}

class _SlideInTransitionState extends State<SlideInTransition> with SingleTickerProviderStateMixin {
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
          child: widget.child,
        );
      },
    );
  }
}
