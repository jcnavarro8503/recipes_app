import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Instruction {
  final String? title;
  final String content;

  Instruction({
    this.title,
    required this.content,
  });
}

class InstructionsCardWidget extends StatefulWidget {
  final List<Instruction> instructions;
  final double? width;

  const InstructionsCardWidget({
    super.key,
    required this.instructions,
    this.width,
  });

  @override
  State<InstructionsCardWidget> createState() => _InstructionsCardWidgetState();
}

class _InstructionsCardWidgetState extends State<InstructionsCardWidget> {
  int activeIndex = 0;
  List<Instruction> myInstructions = [];

  @override
  void initState() {
    super.initState();

    myInstructions.addAll(widget.instructions);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      child: Column(
        children: [
          Card(
            elevation: 0,
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          '${AppLocalizations.of(context)!.step}  ${activeIndex + 1}/${myInstructions.length}'),
                      const Text('Connected to TM6'),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Stack(
                      children: myInstructions.reversed.map((instruction) {
                        return Container(
                          color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                instruction.title ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(instruction.content),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
