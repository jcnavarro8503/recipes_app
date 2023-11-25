import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:recipes_app/core/index.dart';
import 'package:recipes_app/features/index.dart';

class HomeNavWrapper extends StatefulWidget {
  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  const HomeNavWrapper({super.key, required this.navigationShell});

  @override
  State<HomeNavWrapper> createState() => _HomeNavWrapperState();
}

class _HomeNavWrapperState extends State<HomeNavWrapper> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  List<GlobalKey> globalKeys = [];
  late RenderBox box;
  late Offset offset;
  double left = 0;
  double width = 0;
  double height = 0;

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < widget.navigationShell.route.branches.length; i++) {
      globalKeys.add(GlobalKey(debugLabel: 'home_branch_$i'));
    }

    controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInCubic));

    // Run after first frame were painted gett the first button position and size
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        box = globalKeys.first.currentContext!.findRenderObject() as RenderBox;

        setState(() {
          width = box.size.width;
          height = box.size.height;
        });

        controller.forward();
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        debugPrint('HomeBloc state has changed');

        if (state.status == HomeStateStatus.leavePage) {
          controller.reverse();
        } else if (state.status == HomeStateStatus.middlePage) {
          debugPrint('page middle ...');
        } else if (state.status == HomeStateStatus.enterPage) {
          _goToBranch(context, state.index);

          box = globalKeys.elementAt(state.index).currentContext!.findRenderObject() as RenderBox;
          offset = box.localToGlobal(Offset.zero);

          setState(() {
            left = offset.dx < 0 ? 0 : offset.dx - 23;
            width = box.size.width;
            height = box.size.height;
          });

          controller.forward();
        } else if (state.status == HomeStateStatus.showBottomSheet) {
          _showBottomModalSheet(context);
        } else {
          debugPrint('page done ...');
          controller.forward();
        }
      },
      builder: (context, state) {
        return Scaffold(
          // Shell view content
          body: state.status == HomeStateStatus.middlePage
              ? Container()
              : ListenableProvider(
                  create: (context) => animation,
                  child: widget.navigationShell,
                ),

          // Bottom navigation bar
          bottomNavigationBar: SlideInTransition(
            beginOffset: const Offset(0, 0.6),
            endOffset: const Offset(0, 0),
            child: Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
              color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(17)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Stack(
                  children: [
                    // animated widget behind the buttons on the bottom nav bar
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      left: left,
                      child: Container(
                        width: width,
                        height: height,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                    ),

                    // Bottom navigation bar content build dynamically
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: widget.navigationShell.route.branches.map((branch) {
                        // index and global
                        final index = widget.navigationShell.route.branches.indexOf(branch);

                        return BottomNavBarBtnWidget(
                          key: globalKeys[index],
                          assetName: (branch as CustomeStatefulShellBranch).assetName,
                          label: _getBranchLabel(context, branch.assetName),
                          active: state.index == index,
                          onPressed: () {
                            if (index != state.index) {
                              getIt<HomeBloc>().add(HomeIndexChangeEvent(index: index));
                            }
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Navigate to the current location of the branch at the provided index when
  /// tapping an item in the BottomNavigationBar.
  void _goToBranch(BuildContext context, int index) {
    // When navigating to a new branch, it's recommended to use the goBranch
    // method, as doing so makes sure the last navigation state of the
    // Navigator for the branch is restored.
    widget.navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  // get the shell branch name by the asset name
  String _getBranchLabel(BuildContext context, String assets) {
    switch (assets) {
      case 'idea':
        return AppLocalizations.of(context)!.inspirations;
      case 'todo_list':
        return AppLocalizations.of(context)!.my_recipes;
      case 'frying_pan':
        return AppLocalizations.of(context)!.cook_now;
      default:
        return AppLocalizations.of(context)!.settings;
    }
  }

  // show the action bottom sheet
  Future<void> _showBottomModalSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      barrierColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
                Theme.of(context).scaffoldBackgroundColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [.15, 1],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    if (getIt<MyRecipesBloc>().state.selected.label != '') {
                      getIt<HomeBloc>().add(const HomeIndexChangeEvent(index: 2));
                    }
                    // context.go('/${RoutePath.cookNow.path}');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(45),
                    textStyle: const TextStyle(
                      fontFamily: 'WorkSans',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                      ),
                    ),
                  ),
                  child: Text(AppLocalizations.of(context)!.cook_now),
                ),
                const SizedBox(height: 1),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(45),
                    textStyle: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 16,
                    ),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                  child: Text(AppLocalizations.of(context)!.browse_recipe),
                ),
                const SizedBox(height: 1),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(45),
                    textStyle: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 16,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12.0),
                        bottomRight: Radius.circular(12.0),
                      ),
                    ),
                  ),
                  child: Text(AppLocalizations.of(context)!.create_shopping_list),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(45),
                    textStyle: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 16,
                    ),
                  ),
                  child: Text(AppLocalizations.of(context)!.cancel),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
