import 'package:aitebar/core/constants/app_strings.dart';
import 'package:aitebar/core/routes/app_routes/app_router.gr.dart';
import 'package:aitebar/gen/assets.gen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

@RoutePage()
class DashboardPage extends StatefulWidget {
  final int initialIndex;

  const DashboardPage({this.initialIndex = 0, super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<_DashboardPage> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = [
      _DashboardPage(
        pageRouteInfo: HomeRoute(),
        title: AppStrings.home,
        icon: const Icon(LineIcons.home),
      ),
      _DashboardPage(
        pageRouteInfo: UserFundsRaisingRoute(),
        title: 'Funds raising',
        icon: const Icon(LineIcons.coins),
      ),
      _DashboardPage(
        pageRouteInfo: const RequestedFundsRoute(),
        title: AppStrings.requestedFunds,
        icon: const Icon(LineIcons.handHoldingUsDollar),
      ),
      _DashboardPage(
        pageRouteInfo: const SettingsRoute(),
        title: AppStrings.settings,
        icon: const Icon(LineIcons.cog),
        actions: [
          // IconButton(
          //   icon: const Icon(LineIcons.cog),
          //   onPressed: () {
          //     context.router.push(const SettingsRoute());
          //   },
          // ),
        ],
      ),
      // _DashboardPage(
      //   pageRouteInfo: const UserProfileRoute(),
      //   title: AppStrings.profile,
      //   icon: const Icon(LineIcons.user),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(LineIcons.cog),
      //       onPressed: () {
      //         context.router.push(const SettingsRoute());
      //       },
      //     ),
      //   ],
      // ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: _pages.map((e) => e.pageRouteInfo).toList(),
      transitionBuilder: (context, child, animation) {
        return Scaffold(
          appBar: AppBar(
            title: Image.asset(
              Assets.app.appLogoPrimary.path,
              height: kToolbarHeight * 0.8,
            ),
            actions: _pages[context.tabsRouter.activeIndex].actions,
          ),
          body: FadeTransition(
            opacity: animation,
            child: child,
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: context.tabsRouter.activeIndex,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            onDestinationSelected: context.tabsRouter.setActiveIndex,
            destinations: _pages.map(
              (p) {
                return NavigationDestination(
                  label: p.title,
                  icon: p.icon,
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }
}

class _DashboardPage {
  final PageRouteInfo pageRouteInfo;
  final String title;
  final Widget icon;
  final List<Widget> actions;

  _DashboardPage({
    required this.pageRouteInfo,
    required this.title,
    required this.icon,
    this.actions = const [],
  });
}
