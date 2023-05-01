import 'package:aitebar/core/bloc/search/search_cubit.dart';
import 'package:aitebar/core/constants/app_strings.dart';
import 'package:aitebar/core/extensions/build_context_extension.dart';
import 'package:aitebar/core/routes/web_routes/web_router.gr.dart';
import 'package:aitebar/core/sl/service_locator.dart';
import 'package:aitebar/mobile/features/common/presentation/widgets/app_scaffold.dart';
import 'package:aitebar/web/features/auth/domain/models/admin/admin.dart';
import 'package:aitebar/web/features/auth/presentation/bloc/admin/admin_cubit.dart';
import 'package:aitebar/web/features/auth/presentation/pages/auth_page.dart';
import 'package:aitebar/web/features/common/presentation/widget/app_drawer.dart';
import 'package:aitebar/web/features/dashboard/presentation/widgets/app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

@RoutePage()
class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  List<_DashboardPages> _pages = [];
  final SearchCubit _searchCubit = sl<SearchCubit>();

  @override
  void initState() {
    super.initState();
    _pages = [
      // _DashboardPages(
      //   pageRouteInfo: AdminHomeRoute(),
      //   title: AppStrings.home,
      //   icon: const Icon(LineIcons.home),
      // ),
      _DashboardPages(
        pageRouteInfo: UserRoute(),
        title: AppStrings.users,
        icon: const Icon(LineIcons.users),
      ),
      _DashboardPages(
        pageRouteInfo: AllFundsRaisingRoute(),
        title: AppStrings.fundsRaisers,
        icon: const Icon(LineIcons.fileAlt),
      ),
      _DashboardPages(
        pageRouteInfo: AllFundsRequestsRoute(),
        title: AppStrings.fundsRequests,
        icon: const Icon(LineIcons.handHoldingUsDollar),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      homeIndex: 1,
      routes: _pages.map((e) => e.pageRouteInfo).toList(),
      transitionBuilder: (context, child, animation) {
        return AppScaffold(
          drawer: AppDrawer(
            userTile: const UserTile(),
            logoutTile: const _LogoutTile(),
            tiles: List.generate(_pages.length, (i) {
              return ListTile(
                title: Text(_pages[i].title),
                leading: _pages[i].icon,
                onTap: () {
                  _searchCubit.setActiveIndex(i);
                  context.popRoute();
                  context.tabsRouter.setActiveIndex(i);
                },
                selected: context.tabsRouter.activeIndex == i,
                selectedTileColor: context.tabsRouter.activeIndex == i ? context.primary.withOpacity(0.2) : null,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
              );
            }),
            selectedIndex: context.tabsRouter.activeIndex,
          ),
          appBar: MyAppBar(),
          body: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }
}

class UserTile extends StatelessWidget {
  const UserTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AdminCubit, AdminState, Admin?>(
      selector: (state) => state.admin,
      builder: (context, user) {
        if (user == null) {
          return const ListTile(
            title: Text('Login is required'),
          );
        }
        return ListTile(
          leading: const CircleAvatar(child: Icon(LineIcons.user)),
          title: Text(user.name, maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: Text(user.email, maxLines: 1, overflow: TextOverflow.ellipsis),
        );
      },
    );
  }
}

class _LogoutTile extends StatelessWidget {
  const _LogoutTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(LineIcons.alternateSignOut),
      title: const Text(AppStrings.logout),
      onTap: () {
        context.read<AdminCubit>().logout().then((_) {
          context.router.replaceAll([ AuthRoute()]);
        });
      },
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(16.0),
        bottomLeft: Radius.circular(16.0),
      )),
    );
  }
}

class _DashboardPages {
  final PageRouteInfo pageRouteInfo;
  final String title;
  final Widget icon;

  _DashboardPages({
    required this.pageRouteInfo,
    required this.title,
    required this.icon,
  });
}
