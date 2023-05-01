import 'package:aitebar/core/routes/navigation_observer.dart';
import 'package:aitebar/core/routes/web_routes/web_router.dart';
import 'package:aitebar/core/sl/service_locator.dart';
import 'package:aitebar/core/theme/theme_light.dart';
import 'package:aitebar/web/features/auth/presentation/bloc/admin/admin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final _webRouter = WebRouter();

class AitebarWeb extends StatelessWidget {
  const AitebarWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AdminCubit>()..initForRefresh()),
      ],
      child: MaterialApp.router(
        theme: ThemeLight().theme,
        routeInformationParser: _webRouter.defaultRouteParser(),
        routerDelegate: _webRouter.delegate(navigatorObservers: () => [NavigationObserver()]),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
