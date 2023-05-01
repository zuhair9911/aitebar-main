import 'package:aitebar/core/routes/web_routes/web_router.gr.dart';
import 'package:auto_route/auto_route.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class WebRouter extends $WebRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(path: '/', page: WebSplashRoute.page),
    AutoRoute(path: '/login', page: AuthRoute.page),
    AutoRoute(
      path: '/dashboard',
      page: AdminDashboardRoute.page,
      children: [
        AutoRoute(path: 'home', page: AdminHomeRoute.page),
        AutoRoute(path: 'all-funds-raising', page: AllFundsRaisingRoute.page),
        AutoRoute(path: 'users', page: UserRoute.page),
        AutoRoute(path: 'funds-requests', page: AllFundsRequestsRoute.page),
      ],
    ),
    AutoRoute(path: '/funds-details', page: AVFundsDetailsRoute.page),
    AutoRoute(path: '/funds-request-details', page: AVFundsRequestDetailsRoute.page),
  ];
}
