import 'dart:math';

import 'package:flutter/material.dart';
import 'package:recipes_app/core/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CookingTimerWidget extends StatefulWidget {
  final int initial;
  final double width;
  final double height;

  const CookingTimerWidget({
    super.key,
    this.initial = 60,
    this.width = 200,
    this.height = 200,
  });

  @override
  State<CookingTimerWidget> createState() => _CookingTimerWidgetState();
}

class _CookingTimerWidgetState extends State<CookingTimerWidget> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  late int value;
  bool paused = true;

  @override
  void initState() {
    super.initState();

    value = widget.initial;

    controller = AnimationController(
      duration: Duration(seconds: widget.initial),
      vsync: this,
    );

    animation = Tween<double>(begin: 100, end: 0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    animation.removeListener(() {
      setState(() {});
    });
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: CustomPaint(
        foregroundPainter: CircularProgress(
          progress: animation.value,
          trackColor: Theme.of(context).primaryColor.withOpacity(.2),
          progressColor: Theme.of(context).primaryColor.withOpacity(.8),
        ),
        child: GestureDetector(
          onTap: () {
            if (paused) {
              debugPrint('start animation');
              controller.forward();
              setState(() {
                paused = false;
              });
            } else {
              debugPrint('stop animation');
              controller.stop();
              setState(() {
                paused = true;
              });
            }
          },
          onHorizontalDragStart: (details) {
            debugPrint('interrup animation');
            controller.stop();
          },
          onHorizontalDragUpdate: (details) {
            int aux = value + (details.delta.dx.sign >= 0 ? 1 : -1);
            setState(() {
              value = aux >= 0 ? aux : 0;
            });
          },
          onHorizontalDragEnd: (details) {
            debugPrint('setup animation');
            setupAnimation();
          },
          child: Center(
            child: Container(
              width: widget.width * .8,
              height: widget.width * .8,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.width * .5),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor.withOpacity(.4),
                    spreadRadius: 10,
                    blurRadius: 15,
                    offset: const Offset(5, 5), // changes position of shadow
                  ),
                  BoxShadow(
                    color: Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
                    spreadRadius: 10,
                    blurRadius: 10,
                    offset: const Offset(-2.5, -2.5), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(AppLocalizations.of(context)!.program),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        (value * animation.value ~/ 100).toString(),
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'WorkSans',
                            ),
                      ),
                    ),
                    paused
                        ? Container()
                        : IconDataWidget(
                            assetName: 'flare',
                            text: '',
                            sufix: AppLocalizations.of(context)!.cooking,
                          )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setupAnimation() {
    animation.removeListener(() {
      setState(() {});
    });
    controller.dispose();
    controller = AnimationController(
      duration: Duration(seconds: value),
      vsync: this,
    );
    animation = Tween<double>(begin: 100, end: 0).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    setState(() {
      paused = true;
    });
  }
}

class CircularProgress extends CustomPainter {
  final double progress;
  final Color trackColor;
  final double trackRadius;
  final double trackStrokeWidth;
  final Color progressColor;
  final double progressRadius;
  final double progressStrokeWidth;

  CircularProgress({
    required this.progress,
    this.trackColor = Colors.grey,
    this.trackRadius = 80,
    this.trackStrokeWidth = 5,
    this.progressColor = Colors.black,
    this.progressRadius = 80,
    this.progressStrokeWidth = 5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Offset
    Offset center = size
        .center(Offset.zero); //Offset(size.width / 2, size.height / 2); // the center of container

    // track arc
    Paint backgroundTrack = Paint()
      ..strokeWidth = trackStrokeWidth
      ..color = trackColor
      ..style = PaintingStyle.stroke;
    double trackArcAngle = 7 * pi / 4;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.width * .45),
      -pi / 2,
      trackArcAngle,
      false,
      backgroundTrack,
    );

    // progress arc
    Paint progressTrack = Paint()
      ..strokeWidth = progressStrokeWidth
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    double progressArcAngle = (7 * pi / 4) * (progress / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.width * .45),
      -pi / 2,
      progressArcAngle,
      false,
      progressTrack,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
