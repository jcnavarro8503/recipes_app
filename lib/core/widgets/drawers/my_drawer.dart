import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:recipes_app/features/index.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);
  @override
  MyDrawerState createState() => MyDrawerState();
}

class MyDrawerState extends State<MyDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.white,
        child: Scaffold(
          body: ListView(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            children: [
              // Menu 1
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  dense: true,
                  leading: const Icon(
                    Icons.home,
                    size: 40,
                  ),
                  title: Text(AppLocalizations.of(context)!.home),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),

              // Settings
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  dense: true,
                  leading: const Icon(
                    Icons.settings,
                    size: 40,
                  ),
                  title: Text(AppLocalizations.of(context)!.settings),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => ListenableProvider(
                          create: (contex) => animation,
                          child: const SettingsPage(),
                        ),
                        transitionDuration: const Duration(
                          milliseconds: 500,
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Close App
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  dense: true,
                  leading: const Icon(
                    Icons.exit_to_app,
                    size: 40,
                  ),
                  title: const Text(
                      // AppLocalizations.of(context)!.signout,
                      'Cerrar App'),
                  onTap: () {
                    sleep(const Duration(milliseconds: 200));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
