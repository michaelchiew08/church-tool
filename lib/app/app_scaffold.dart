import 'package:church_tool/app/app.dart';
import 'package:church_tool/app/custom_drawer.dart';
import 'package:church_tool/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppScaffold extends ConsumerWidget {
  const AppScaffold({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // ignore: no_leading_underscores_for_local_identifiers
        final _isDrawerFixed = isDrawerFixed(constraints.maxWidth);

        final selectedSection = computeSelectedSection(context);

        final drawer = CustomDrawer(
          isDrawerFixed: _isDrawerFixed,
          openSearch: () {},
        );

        if (_isDrawerFixed) {
          return Scaffold(
            body: SafeArea(
              child: Row(
                children: <Widget>[
                  drawer,
                  Expanded(child: child),
                ],
              ),
            ),
            // floatingActionButton: (selectedSection == AppPage.pinyinConverter &&
            //         MediaQuery.viewInsetsOf(context).bottom == 0)
            //     ? FloatingActionButton(
            //         key: const ValueKey('clearAll'),
            //         onPressed: () {},
            //         tooltip: 'Clear All',
            //         child: const Icon(Icons.clear_outlined),
            //       )
            //     : null,
          );
        }
        // if the drawer is not fixed
        return PopScope(
          canPop: selectedSection == AppPage.pinyinConverter,
          onPopInvoked: (didPop) {
            if (selectedSection == AppPage.settings) {
              context.go('/');
            } else if (selectedSection == AppPage.reorder) {
              context.goNamed('settings');
            } else if (selectedSection == AppPage.reorderDetails) {
              //2 sided page
              if (_isDrawerFixed) {
                context.goNamed('settings');
              }
              // if (!_isDrawerFixed) {
              //   context.goNamed('reorder-units');
              // }
            }
          },
          child: Scaffold(
            drawer: drawer,
            body: SafeArea(child: child),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endContained,
            bottomNavigationBar: selectedSection == AppPage.pinyinConverter
                ? BottomAppBar(
                    child: Row(
                      children: [
                        IconButton(
                          tooltip: 'Search',
                          icon: const Icon(Icons.search),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  )
                : null,
            // floatingActionButton: (selectedSection == AppPage.pinyinConverter &&
            //         MediaQuery.viewInsetsOf(context).bottom == 0)
            //     ? FloatingActionButton(
            //         key: const ValueKey('clearAll'),
            //         onPressed: () {},
            //         tooltip: 'Clear All',
            //         child: const Icon(Icons.clear_outlined),
            //       )
            //     : null,
          ),
        );
      },
    );
  }
}
