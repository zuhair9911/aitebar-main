import 'package:auto_route/auto_route.dart';

// import '../web_routes/web_router.gr.dart';
import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  static const welcome = '/welcome';
  static const signIn = '/sign-in';
  static const signUp = '/sign-up';
  static const fundsDetails = '/funds-details';
  static const createFundsRaisingPost = '/create-funds-raising-post';
  static const accountDetails = '/account-details';

// dashboard and  tabs
  static const dashboard = '/dashboard';
  static const home = 'home';
  static const myFundsRaising = 'my-funds-raising';
  static const profile = 'profile';
  static const requestedFunds = 'requested-funds';
  static const settings = 'settings';

  static var forgotPassword = '/forgot-password';
  static var mainPage = '/main';

  @override
  RouteType get defaultRouteType => const RouteType.cupertino();
  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: SplashRoute.page, path: '/'),
    AutoRoute(page: WelcomeRoute.page, path: welcome),
    AutoRoute(path: dashboard, page: DashboardRoute.page, children: [
      AutoRoute(path: home, page: HomeRoute.page),
      AutoRoute(path: myFundsRaising, page: UserFundsRaisingRoute.page),
      AutoRoute(path: requestedFunds, page: RequestedFundsRoute.page),
      AutoRoute(path: settings, page: SettingsRoute.page),
    ]),
    AutoRoute(path: fundsDetails, page: FundsDetailsRoute.page),
    AutoRoute(path: accountDetails, page: DonationAccountDetailsRoute.page),
    AutoRoute(path: createFundsRaisingPost, page: CreateFundsRaisingRoute.page),
    AutoRoute(path: signIn, page: SignInRoute.page),
    AutoRoute(path: signUp, page: SignUpRoute.page),
    AutoRoute(path: forgotPassword, page: ForgotPasswordRoute.page),
    AutoRoute(path: mainPage, page: MainRoute.page),
    AutoRoute(
        path: '/create-funds-request', page: CreateFundsRequestRoute.page),
    AutoRoute(
        path: '/funds-request-details', page: AVFundsRequestDetailsRoute.page),
  ];
}
