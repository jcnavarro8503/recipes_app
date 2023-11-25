import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:recipes_app/core/index.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Upper title
          FadeInSlidingAlignTransition(
            duration: const Duration(milliseconds: 1000),
            align: Alignment.topCenter,
            beginOffset: const Offset(0, -1),
            endOffset: const Offset(0, 0),
            beginOpacity: 0,
            endOpacity: 1,
            child: AppBarWidget(
              title: AppLocalizations.of(context)!.appTitle,
              showBack: false,
            ),
          ),

          // Centered Logo and text
          FadeInSlidingAlignTransition(
            delay: const Duration(milliseconds: 1500),
            duration: const Duration(milliseconds: 800),
            align: Alignment.center,
            beginOffset: const Offset(0, 0.05),
            endOffset: const Offset(0, 0),
            beginOpacity: 0,
            endOpacity: 1,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: ThemeSvgWidget(assetName: 'logo'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: MediaQuery.of(context).size.width * .1,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.landing_title,
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                fontFamily: 'WorkSans',
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          AppLocalizations.of(context)!.landing_subtitle,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Nunito',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottomed buttom
          FadeInSlidingAlignTransition(
            delay: const Duration(milliseconds: 1800),
            duration: const Duration(milliseconds: 1500),
            align: Alignment.bottomCenter,
            beginOffset: const Offset(0, .8),
            endOffset: const Offset(0, 0),
            beginOpacity: 0,
            endOpacity: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: ElevatedButton(
                onPressed: () {
                  context.go('/${RoutePath.inspirations.path}');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(45),
                ),
                child: Text(AppLocalizations.of(context)!.lets_start),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
