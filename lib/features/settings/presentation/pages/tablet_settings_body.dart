import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:recipes_app/core/index.dart';
import 'package:recipes_app/features/index.dart';

class TabletSettingsBody extends StatefulWidget {
  const TabletSettingsBody({super.key});

  @override
  State<TabletSettingsBody> createState() => _TabletSettingsBodyState();
}

class _TabletSettingsBodyState extends State<TabletSettingsBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          // Page content
          Center(
            child: Column(
              children: [
                const SizedBox(height: 80),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SlidingTransition(
                        beginOffset: const Offset(0, 1),
                        endOffset: const Offset(0, 0),
                        start: 0,
                        end: 1,
                        curve: Curves.easeOutCubic,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(vertical: 10),
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(Icons.language),
                              ),
                              Text(AppLocalizations.of(context)!.lenguage),
                            ],
                          ),
                          subtitle: BlocBuilder<LocalizationBloc, LocalizationState>(
                            builder: (context, state) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  children: [
                                    LanguageWidget(
                                      title: AppLocalizations.of(context)!.spanish,
                                      active: state.locale.languageCode == 'es',
                                      onTap: () {
                                        if (state.locale.languageCode != 'es') {
                                          getIt<LocalizationBloc>().add(
                                              const LocalizationChangeEvent(
                                                  locale: Locale('es', '')));
                                        }
                                      },
                                    ),
                                    LanguageWidget(
                                      title: AppLocalizations.of(context)!.english,
                                      active: state.locale.languageCode == 'en',
                                      onTap: () {
                                        if (state.locale.languageCode != 'en') {
                                          getIt<LocalizationBloc>().add(
                                              const LocalizationChangeEvent(
                                                  locale: Locale('en', '')));
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SlidingTransition(
                        beginOffset: const Offset(0, 1),
                        endOffset: const Offset(0, 0),
                        start: 0.3,
                        end: 1,
                        curve: Curves.easeOutCubic,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(vertical: 10),
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(Icons.phone_android),
                              ),
                              Text(AppLocalizations.of(context)!.theme),
                            ],
                          ),
                          subtitle: BlocBuilder<ThemeBloc, ThemeState>(
                            builder: (context, state) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  children: Themes.values
                                      .map(
                                        (themeItem) => ThemeWidget(
                                          title: themeItem.toString(),
                                          theme: themesData[themeItem]!,
                                          active: state.theme == themeItem,
                                          onTap: () {
                                            getIt<ThemeBloc>()
                                                .add(ThemeChangeEvent(theme: themeItem));
                                          },
                                        ),
                                      )
                                      .toList(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Page Title
          SlidingTransition(
            beginOffset: const Offset(0, -1),
            endOffset: const Offset(0, 0),
            start: 0,
            end: 0.5,
            child: AppBarWidget(
              title: AppLocalizations.of(context)!.settings,
              showBack: false,
            ),
          ),
        ],
      ),
    );
  }
}
